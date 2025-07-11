import 'package:get_it/get_it.dart';
import 'package:invoice_app/fetures/auth/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupLocator() {
  final supabase = Supabase.instance.client;
  GetIt.instance.registerSingleton<SupabaseClient>(supabase);

  final authService = AuthService(supabaseClient: supabase);
  GetIt.instance.registerSingleton<AuthService>(authService);
}
