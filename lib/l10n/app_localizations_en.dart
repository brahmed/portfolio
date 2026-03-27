// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navAbout => 'About';

  @override
  String get navProjects => 'Projects';

  @override
  String get navSkills => 'Skills';

  @override
  String get navContact => 'Contact';

  @override
  String get heroTitle => 'Flutter Developer';

  @override
  String get heroSubtitle =>
      'Crafting beautiful, performant mobile & web experiences';

  @override
  String get heroCta => 'View Projects';

  @override
  String get aboutTitle => 'About Me';

  @override
  String get aboutBody =>
      'Mobile Software Engineer with 4 years of experience designing and delivering high-quality applications. Skilled in Flutter and Dart, I aim to build innovative products that enhance user experiences and drive project success.';

  @override
  String get aboutLinkedIn => 'LinkedIn';

  @override
  String get aboutGitHub => 'GitHub';

  @override
  String get aboutEmail => 'Email';

  @override
  String get projectsTitle => 'Projects';

  @override
  String get projectsEmpty => 'No projects available.';

  @override
  String get projectsError => 'Failed to load projects.';

  @override
  String get projectsRetry => 'Retry';

  @override
  String get projectPlayStore => 'Play Store';

  @override
  String get projectAppStore => 'App Store';

  @override
  String get projectScreenshots => 'Screenshots';

  @override
  String get skillsTitle => 'Skills';

  @override
  String get skillsGroupFlutter => 'Frameworks & Technologies';

  @override
  String get skillsGroupFirebase => 'Tools & Platforms';

  @override
  String get skillsGroupArchitecture => 'Methodologies';

  @override
  String get skillsGroupTools => 'CI/CD';

  @override
  String get skillsGroupLanguages => 'Programming Languages';

  @override
  String get contactTitle => 'Get In Touch';

  @override
  String get contactSubtitle =>
      'Have a project in mind or want to collaborate? Send me a message.';

  @override
  String get contactNameLabel => 'Name';

  @override
  String get contactEmailLabel => 'Email';

  @override
  String get contactMessageLabel => 'Message';

  @override
  String get contactSendButton => 'Send Message';

  @override
  String get contactSending => 'Sending...';

  @override
  String get contactSuccess => 'Message sent successfully!';

  @override
  String get contactError => 'Something went wrong. Please try again.';

  @override
  String get contactNameRequired => 'Name is required';

  @override
  String get contactEmailInvalid => 'Enter a valid email address';

  @override
  String get contactMessageRequired => 'Message is required';

  @override
  String get contactMessageTooLong =>
      'Message must be 2000 characters or fewer';

  @override
  String get themeToggleLight => 'Light mode';

  @override
  String get themeToggleDark => 'Dark mode';

  @override
  String get footerRights => 'All rights reserved';
}
