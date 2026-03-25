import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/projects/data/project_model.dart';
import 'package:portfolio/features/projects/domain/project_repository_interface.dart';

/// Minimal in-memory stub of [ProjectRepositoryInterface] for testing.
class _StubRepository implements ProjectRepositoryInterface {
  _StubRepository(this._projects);

  final List<ProjectModel> _projects;

  @override
  Stream<List<ProjectModel>> watchProjects() => Stream.value(_projects);
}

ProjectModel _makeProject({
  String slug = 'test-project',
  int sortOrder = 0,
  bool isVisible = true,
}) =>
    ProjectModel(
      slug: slug,
      titleEn: 'Title EN',
      titleFr: 'Titre FR',
      titleAr: 'عنوان',
      descriptionEn: 'Desc EN',
      descriptionFr: 'Desc FR',
      descriptionAr: 'وصف',
      categoryEn: 'Mobile',
      categoryFr: 'Mobile',
      categoryAr: 'موبايل',
      techTags: const ['Flutter', 'Dart'],
      imageUrl: 'https://example.com/image.png',
      sortOrder: sortOrder,
      isVisible: isVisible,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=test',
      appStoreUrl: null,
    );

void main() {
  group('ProjectRepositoryInterface contract', () {
    test('emits list of projects from stream', () async {
      final projects = [_makeProject(slug: 'p1'), _makeProject(slug: 'p2')];
      final repo = _StubRepository(projects);

      final result = await repo.watchProjects().first;

      expect(result.length, 2);
      expect(result.first.slug, 'p1');
    });

    test('emits empty list when no projects', () async {
      final repo = _StubRepository([]);
      final result = await repo.watchProjects().first;
      expect(result, isEmpty);
    });
  });

  group('ProjectModel locale helpers', () {
    final project = _makeProject();

    test('localizedTitle returns EN by default', () {
      expect(project.localizedTitle('en'), 'Title EN');
    });

    test('localizedTitle returns FR for fr locale', () {
      expect(project.localizedTitle('fr'), 'Titre FR');
    });

    test('localizedTitle returns AR for ar locale', () {
      expect(project.localizedTitle('ar'), 'عنوان');
    });

    test('unknown locale falls back to EN', () {
      expect(project.localizedTitle('de'), 'Title EN');
    });

    test('localizedDescription returns correct locale', () {
      expect(project.localizedDescription('fr'), 'Desc FR');
    });

    test('localizedCategory returns correct locale', () {
      expect(project.localizedCategory('ar'), 'موبايل');
    });
  });

  group('ProjectModel JSON round-trip', () {
    test('toJson / fromJson preserves all fields', () {
      final original = _makeProject(slug: 'round-trip', sortOrder: 3);
      final json = original.toJson()..['slug'] = original.slug;
      final restored = ProjectModel.fromJson(json);

      expect(restored.slug, original.slug);
      expect(restored.titleEn, original.titleEn);
      expect(restored.techTags, original.techTags);
      expect(restored.sortOrder, original.sortOrder);
      expect(restored.playStoreUrl, original.playStoreUrl);
      expect(restored.appStoreUrl, isNull);
    });
  });
}
