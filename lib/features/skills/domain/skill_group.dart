/// A named group of skill tags displayed in the Skills section.
class SkillGroup {
  const SkillGroup({required this.titleKey, required this.skills});

  /// ARB key used to look up the localised group title.
  final String titleKey;
  final List<String> skills;
}

/// All skill groups — hardcoded from resume.
const skillGroups = [
  SkillGroup(
    titleKey: 'skillsGroupFlutter',
    skills: [
      'Flutter',
      'Dart',
      'Flutter Web',
      'Custom Painter',
      'Animations',
      'Provider',
      'BLoC',
      'Riverpod',
    ],
  ),
  SkillGroup(
    titleKey: 'skillsGroupFirebase',
    skills: [
      'Firestore',
      'Firebase Auth',
      'Firebase Hosting',
      'Firebase Storage',
      'Cloud Functions',
    ],
  ),
  SkillGroup(
    titleKey: 'skillsGroupArchitecture',
    skills: [
      'Clean Architecture',
      'MVVM',
      'Repository Pattern',
      'Domain-Driven Design',
      'REST APIs',
      'Method Channels',
    ],
  ),
  SkillGroup(
    titleKey: 'skillsGroupTools',
    skills: [
      'Git',
      'GitHub Actions',
      'Fastlane',
      'Codemagic',
      'Jira',
      'Figma',
    ],
  ),
  SkillGroup(
    titleKey: 'skillsGroupLanguages',
    skills: ['Arabic', 'French', 'English'],
  ),
];
