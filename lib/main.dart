import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/app.dart';
import 'package:invoice_app/utils/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupSupabase();
  setupLocator();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> setupSupabase() async {
  const url = String.fromEnvironment('SUPABASE_URL');
  const anonKey = String.fromEnvironment('ANON_KEY');
  assert(url.isNotEmpty, "SUPABASE_URL is missing");
  assert(anonKey.isNotEmpty, "ANON_KEY is missing");
  await Supabase.initialize(url: url, anonKey: anonKey);
}
