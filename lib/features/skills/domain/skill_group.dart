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
    titleKey: 'skillsGroupLanguages',
    skills: ['Dart', 'Swift', 'Java', 'Kotlin'],
  ),
  SkillGroup(
    titleKey: 'skillsGroupFlutter',
    skills: ['Flutter', 'Android', 'iOS'],
  ),
  SkillGroup(
    titleKey: 'skillsGroupFirebase',
    skills: [
      'Firebase',
      'Figma',
      'Git',
      'Bitbucket',
      'GitLab',
      'Jira',
      'Confluence',
    ],
  ),
  SkillGroup(
    titleKey: 'skillsGroupArchitecture',
    skills: ['Agile', 'Scrum', 'Kanban'],
  ),
  SkillGroup(
    titleKey: 'skillsGroupTools',
    skills: ['Jenkins', 'Fastlane', 'Firebase App Distribution'],
  ),
];
