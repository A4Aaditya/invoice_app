import 'package:flutter/material.dart';
import 'package:invoice_app/i18n/app_localizations.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/pages/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final SupabaseClient client;
  @override
  Widget build(BuildContext context) {
    final currentUser = client.auth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: currentUser == null
          ? const SplashScreen()
          : const DashboardScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
