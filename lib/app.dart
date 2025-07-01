import 'package:flutter/material.dart';
import 'package:invoice_app/i18n/app_localizations.dart';
import 'package:invoice_app/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
