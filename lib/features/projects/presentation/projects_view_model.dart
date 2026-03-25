import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/utils/logger.dart';
import '../data/project_model.dart';
import '../domain/project_repository_interface.dart';

enum ProjectsStatus { loading, success, error }

/// Owns the projects list state, sourced from Firestore via [ProjectRepositoryInterface].
class ProjectsViewModel extends ChangeNotifier {
  ProjectsViewModel({required ProjectRepositoryInterface repository})
      : _repository = repository {
    _subscribe();
  }

  final ProjectRepositoryInterface _repository;
  StreamSubscription<List<ProjectModel>>? _subscription;

  ProjectsStatus _status = ProjectsStatus.loading;
  List<ProjectModel> _projects = [];

  ProjectsStatus get status => _status;
  List<ProjectModel> get projects => _projects;

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
