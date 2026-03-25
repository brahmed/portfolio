import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/logger.dart';
import '../domain/project_repository_interface.dart';
import 'project_model.dart';

/// Firestore-backed implementation of [ProjectRepositoryInterface].
class ProjectRepository implements ProjectRepositoryInterface {
  ProjectRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<List<ProjectModel>> watchProjects() {
    return _firestore
        .collection('projects')
        .where('is_visible', isEqualTo: true)
        .orderBy('sort_order')
        .snapshots()
        .map((snapshot) {
      try {
        return snapshot.docs
            .map(ProjectModel.fromFirestore)
            .toList(growable: false);
      } catch (e, st) {
        logError(
          'ProjectRepository.watchProjects parse error',
          error: e,
          stackTrace: st,
        );
        rethrow;
      }
    });
  }
}
