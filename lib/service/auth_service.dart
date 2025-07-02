import 'package:get_it/get_it.dart';
import 'package:invoice_app/model/auth_service_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabaseClient = GetIt.instance.get<SupabaseClient>();

  Future<AuthServiceResponse> signinWithPassword({
    required String password,
    required String email,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      return AuthServiceResponse(
        session: response.session,
        user: response.user,
      );
    } on AuthException catch (e) {
      return AuthServiceResponse(
        message: e.message,
        statusCode: e.statusCode,
        code: e.code,
      );
    } catch (e) {
      return AuthServiceResponse();
    }
  }
}
