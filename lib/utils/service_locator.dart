import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void setupLocator() {
  final supabase = Supabase.instance.client;
  GetIt.instance.registerSingleton<SupabaseClient>(supabase);
}
