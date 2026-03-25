import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

/// Firestore document model for a project.
///
/// Field names use the `_en` / `_fr` / `_ar` convention so all locales live
/// in the same document and no cloud function is needed.
@JsonSerializable()
class ProjectModel {
  const ProjectModel({
    required this.slug,
    required this.titleEn,
    required this.titleFr,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionFr,
    required this.descriptionAr,
    required this.categoryEn,
    required this.categoryFr,
    required this.categoryAr,
    required this.techTags,
    required this.imageUrl,
    required this.sortOrder,
    required this.isVisible,
    this.playStoreUrl,
    this.appStoreUrl,
  });

  final String slug;

  @JsonKey(name: 'title_en')
  final String titleEn;
  @JsonKey(name: 'title_fr')
  final String titleFr;
  @JsonKey(name: 'title_ar')
  final String titleAr;

  @JsonKey(name: 'description_en')
  final String descriptionEn;
  @JsonKey(name: 'description_fr')
  final String descriptionFr;
  @JsonKey(name: 'description_ar')
  final String descriptionAr;

  @JsonKey(name: 'category_en')
  final String categoryEn;
  @JsonKey(name: 'category_fr')
  final String categoryFr;
  @JsonKey(name: 'category_ar')
  final String categoryAr;

  @JsonKey(name: 'tech_tags')
  final List<String> techTags;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @JsonKey(name: 'is_visible')
  final bool isVisible;

  @JsonKey(name: 'play_store_url')
  final String? playStoreUrl;

  @JsonKey(name: 'app_store_url')
  final String? appStoreUrl;

  // ── Locale helpers ──────────────────────────────────────────────────────────

  String localizedTitle(String languageCode) => switch (languageCode) {
        'fr' => titleFr,
        'ar' => titleAr,
        _ => titleEn,
      };

  String localizedDescription(String languageCode) => switch (languageCode) {
        'fr' => descriptionFr,
        'ar' => descriptionAr,
        _ => descriptionEn,
      };

  String localizedCategory(String languageCode) => switch (languageCode) {
        'fr' => categoryFr,
        'ar' => categoryAr,
        _ => categoryEn,
      };

  // ── Firestore ────────────────────────────────────────────────────────────────

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProjectModel.fromJson({...data, 'slug': doc.id});
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}
