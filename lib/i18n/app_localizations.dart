import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
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
    Locale('hi'),
  ];

  /// This is shown in Splash Screen
  ///
  /// In en, this message translates to:
  /// **'Invoice App'**
  String get appName;

  /// No description provided for @homePageName.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homePageName;

  /// No description provided for @invoicePageName.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoicePageName;

  /// No description provided for @transactionPageName.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transactionPageName;

  /// No description provided for @settingPageName.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingPageName;

  /// No description provided for @settingAccountTile.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingAccountTile;

  /// No description provided for @settingAccountTileDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage your account'**
  String get settingAccountTileDescription;

  /// No description provided for @settingNotificationTile.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingNotificationTile;

  /// No description provided for @settingNotificationTileDescription.
  ///
  /// In en, this message translates to:
  /// **'Notification preferences'**
  String get settingNotificationTileDescription;

  /// No description provided for @settingPrivacyTile.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingPrivacyTile;

  /// No description provided for @settingPrivacyTileDescription.
  ///
  /// In en, this message translates to:
  /// **'Privacy settings'**
  String get settingPrivacyTileDescription;

  /// No description provided for @settingThemeTile.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingThemeTile;

  /// No description provided for @settingThemeTileDescription.
  ///
  /// In en, this message translates to:
  /// **'Light / Dark mode'**
  String get settingThemeTileDescription;

  /// No description provided for @settingLanguageTile.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingLanguageTile;

  /// No description provided for @settingLanguageTileDescription.
  ///
  /// In en, this message translates to:
  /// **'Select app language'**
  String get settingLanguageTileDescription;

  /// No description provided for @settingLanguageTileChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get settingLanguageTileChooseLanguage;

  /// No description provided for @settingLanguageTileChooseEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingLanguageTileChooseEnglish;

  /// No description provided for @settingLanguageTileChooseHindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get settingLanguageTileChooseHindi;

  /// No description provided for @settingAboutTile.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingAboutTile;

  /// No description provided for @settingAboutTileDescription.
  ///
  /// In en, this message translates to:
  /// **'App information'**
  String get settingAboutTileDescription;

  /// No description provided for @settingLogoutTile.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingLogoutTile;

  /// No description provided for @settingLogoutTileDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get settingLogoutTileDescription;

  /// No description provided for @settingCofirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get settingCofirmLogout;

  /// No description provided for @settingConfirmText.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be logged out'**
  String get settingConfirmText;

  /// No description provided for @settingCancelButtonName.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingCancelButtonName;

  /// No description provided for @settingLogoutButtonName.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingLogoutButtonName;

  /// No description provided for @registerScreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerScreeTitle;

  /// No description provided for @registerScreenHintEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerScreenHintEmail;

  /// No description provided for @registerScreenHintPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registerScreenHintPassword;

  /// No description provided for @registerScreenRegisterButtonName.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerScreenRegisterButtonName;

  /// No description provided for @registerScreenText.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerScreenText;

  /// No description provided for @registerScreenLoginButtonName.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get registerScreenLoginButtonName;

  /// No description provided for @loginRegisterScreenWelcomeText.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get loginRegisterScreenWelcomeText;

  /// No description provided for @loginScreenLoginAccount.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get loginScreenLoginAccount;

  /// No description provided for @loginScreenEmailText.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginScreenEmailText;

  /// No description provided for @loginScreenPasswordText.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginScreenPasswordText;

  /// No description provided for @loginScreenLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginScreenLoginButton;

  /// No description provided for @loginScreenSignupButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get loginScreenSignupButton;

  /// No description provided for @loginScreenDontAccountText.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginScreenDontAccountText;
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
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
