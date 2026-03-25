import '../data/project_model.dart';

/// Contract for fetching the projects list.
abstract interface class ProjectRepositoryInterface {
  /// Returns a stream of visible projects ordered by [sortOrder].
  Stream<List<ProjectModel>> watchProjects();
}
