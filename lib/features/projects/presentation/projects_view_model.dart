import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/utils/logger.dart';
import '../data/project_model.dart';
import '../domain/project_repository_interface.dart';

enum ProjectsStatus { idle, loading, success, error }

/// Owns the projects list state, sourced from Firestore via [ProjectRepositoryInterface].
///
/// Call [startListening] once the projects section becomes visible to defer
/// the Firestore subscription until it is actually needed.
class ProjectsViewModel extends ChangeNotifier {
  ProjectsViewModel({required ProjectRepositoryInterface repository})
      : _repository = repository;

  final ProjectRepositoryInterface _repository;
  StreamSubscription<List<ProjectModel>>? _subscription;

  ProjectsStatus _status = ProjectsStatus.idle;
  List<ProjectModel> _projects = [];

  ProjectsStatus get status => _status;
  List<ProjectModel> get projects => _projects;

  bool _started = false;

  /// Starts the Firestore subscription. Safe to call multiple times — only
  /// subscribes once.
  void startListening() {
    if (_started) return;
    _started = true;
    _status = ProjectsStatus.loading;
    _subscribe();
  }

  void _subscribe() {
    _subscription = _repository.watchProjects().listen(
      (data) {
        _projects = data;
        _status = ProjectsStatus.success;
        notifyListeners();
      },
      onError: (Object e, StackTrace st) {
        logError(
          'ProjectsViewModel stream error',
          error: e,
          stackTrace: st,
        );
        _status = ProjectsStatus.error;
        notifyListeners();
      },
    );
  }

  void retry() {
    _status = ProjectsStatus.loading;
    notifyListeners();
    _subscription?.cancel();
    _subscribe();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
