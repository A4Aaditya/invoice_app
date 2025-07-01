import 'package:flutter/material.dart';
import 'package:invoice_app/i18n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get i18n => AppLocalizations.of(this)!;
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
