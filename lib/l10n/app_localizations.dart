import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('ar')
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @navExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get navExperience;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get navSkills;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Senior Flutter Developer'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Crafting beautiful, performant mobile & web experiences'**
  String get heroSubtitle;

  /// No description provided for @heroCta.
  ///
  /// In en, this message translates to:
  /// **'View Projects'**
  String get heroCta;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutTitle;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'Mobile Software Engineer with 4 years of experience designing and delivering high-quality applications. Skilled in Flutter and Dart, I aim to build innovative products that enhance user experiences and drive project success.'**
  String get aboutBody;

  /// No description provided for @aboutLinkedIn.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get aboutLinkedIn;

  /// No description provided for @aboutGitHub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get aboutGitHub;

  /// No description provided for @aboutEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get aboutEmail;

  /// No description provided for @experienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experienceTitle;

  /// No description provided for @exp1Role.
  ///
  /// In en, this message translates to:
  /// **'Mobile Software Engineer'**
  String get exp1Role;

  /// No description provided for @exp1Company.
  ///
  /// In en, this message translates to:
  /// **'Value Digital Services'**
  String get exp1Company;

  /// No description provided for @exp1Period.
  ///
  /// In en, this message translates to:
  /// **'September 2022 – Present'**
  String get exp1Period;

  /// No description provided for @exp1Description.
  ///
  /// In en, this message translates to:
  /// **'Leading a team of Flutter developers to design, build, and deliver high-quality mobile applications. Applied clean architecture and CI/CD pipelines. Mentored junior developers and conducted code reviews.'**
  String get exp1Description;

  /// No description provided for @exp2Role.
  ///
  /// In en, this message translates to:
  /// **'Mobile Software Engineer'**
  String get exp2Role;

  /// No description provided for @exp2Company.
  ///
  /// In en, this message translates to:
  /// **'Teamwill Group'**
  String get exp2Company;

  /// No description provided for @exp2Period.
  ///
  /// In en, this message translates to:
  /// **'January 2022 – August 2022'**
  String get exp2Period;

  /// No description provided for @exp2Description.
  ///
  /// In en, this message translates to:
  /// **'Integrated biometric authentication SDK into a Flutter app using Kotlin method channels. Developed features for a Flutter mobile and web application enabling credit simulations.'**
  String get exp2Description;

  /// No description provided for @exp3Role.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer Intern'**
  String get exp3Role;

  /// No description provided for @exp3Company.
  ///
  /// In en, this message translates to:
  /// **'Munic Car Data'**
  String get exp3Company;

  /// No description provided for @exp3Period.
  ///
  /// In en, this message translates to:
  /// **'June 2020 – December 2020'**
  String get exp3Period;

  /// No description provided for @exp3Description.
  ///
  /// In en, this message translates to:
  /// **'Developed features for a Telematics Mobile App. Built Flutter packages forming a generic SDK with documentation for Telematics app development.'**
  String get exp3Description;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsTitle;

  /// No description provided for @projectsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No projects available.'**
  String get projectsEmpty;

  /// No description provided for @projectsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load projects.'**
  String get projectsError;

  /// No description provided for @projectsRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get projectsRetry;

  /// No description provided for @projectPlayStore.
  ///
  /// In en, this message translates to:
  /// **'Play Store'**
  String get projectPlayStore;

  /// No description provided for @projectAppStore.
  ///
  /// In en, this message translates to:
  /// **'App Store'**
  String get projectAppStore;

  /// No description provided for @skillsTitle.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skillsTitle;

  /// No description provided for @skillsGroupFlutter.
  ///
  /// In en, this message translates to:
  /// **'Flutter & Dart'**
  String get skillsGroupFlutter;

  /// No description provided for @skillsGroupFirebase.
  ///
  /// In en, this message translates to:
  /// **'Firebase'**
  String get skillsGroupFirebase;

  /// No description provided for @skillsGroupArchitecture.
  ///
  /// In en, this message translates to:
  /// **'Architecture'**
  String get skillsGroupArchitecture;

  /// No description provided for @skillsGroupTools.
  ///
  /// In en, this message translates to:
  /// **'Tools & CI/CD'**
  String get skillsGroupTools;

  /// No description provided for @skillsGroupLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get skillsGroupLanguages;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch'**
  String get contactTitle;

  /// No description provided for @contactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Have a project in mind or want to collaborate? Send me a message.'**
  String get contactSubtitle;

  /// No description provided for @contactNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactNameLabel;

  /// No description provided for @contactEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactEmailLabel;

  /// No description provided for @contactMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get contactMessageLabel;

  /// No description provided for @contactSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contactSendButton;

  /// No description provided for @contactSending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get contactSending;

  /// No description provided for @contactSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get contactSuccess;

  /// No description provided for @contactError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get contactError;

  /// No description provided for @contactNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get contactNameRequired;

  /// No description provided for @contactEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get contactEmailInvalid;

  /// No description provided for @contactMessageRequired.
  ///
  /// In en, this message translates to:
  /// **'Message is required'**
  String get contactMessageRequired;

  /// No description provided for @contactMessageTooLong.
  ///
  /// In en, this message translates to:
  /// **'Message must be 2000 characters or fewer'**
  String get contactMessageTooLong;

  /// No description provided for @themeToggleLight.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get themeToggleLight;

  /// No description provided for @themeToggleDark.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get themeToggleDark;

  /// No description provided for @footerRights.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved'**
  String get footerRights;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
