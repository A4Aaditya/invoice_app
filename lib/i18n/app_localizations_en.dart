// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Invoice App';

  @override
  String get homePageName => 'Home';

  @override
  String get invoicePageName => 'Invoice';

  @override
  String get transactionPageName => 'Transaction';

  @override
  String get settingPageName => 'Settings';

  @override
  String get settingAccountTile => 'Account';

  @override
  String get settingAccountTileDescription => 'Manage your account';

  @override
  String get settingNotificationTile => 'Notifications';

  @override
  String get settingNotificationTileDescription => 'Notification preferences';

  @override
  String get settingPrivacyTile => 'Privacy';

  @override
  String get settingPrivacyTileDescription => 'Privacy settings';

  @override
  String get settingThemeTile => 'Theme';

  @override
  String get settingThemeTileDescription => 'Light / Dark mode';

  @override
  String get settingLanguageTile => 'Language';

  @override
  String get settingLanguageTileDescription => 'Select app language';

  @override
  String get settingLanguageTileChooseLanguage => 'Choose Language';

  @override
  String get settingLanguageTileChooseEnglish => 'English';

  @override
  String get settingLanguageTileChooseHindi => 'Hindi';

  @override
  String get settingAboutTile => 'About';

  @override
  String get settingAboutTileDescription => 'App information';

  @override
  String get settingLogoutTile => 'Logout';

  @override
  String get settingLogoutTileDescription => 'Sign out of your account';
}
