import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:invoice_app/i18n/app_localizations.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/pages/splash_screen.dart';
import 'package:invoice_app/riverpod/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = GetIt.instance.get<SupabaseClient>();
    final currentUser = client.auth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider),
      home: currentUser == null
          ? const SplashScreen()
          : const DashboardScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
