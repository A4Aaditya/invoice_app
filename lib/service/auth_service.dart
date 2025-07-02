import 'package:invoice_app/entities/auth_params/login_params.dart';
import 'package:invoice_app/entities/auth_params/no_params.dart';
import 'package:invoice_app/entities/auth_params/register_params.dart';
import 'package:invoice_app/model/auth_service_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabaseClient;
  AuthService({required this.supabaseClient});

  Future<AuthServiceResponse> signinWithPassword(
    LoginParams loginParams,
  ) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: loginParams.password,
        email: loginParams.email,
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

  Future<AuthServiceResponse> registerEmailPassword(
    RegisterParams registerParams,
  ) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: registerParams.password,
        email: registerParams.email,
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

  Future<void> signOut(NoParams noParams) async {
    await supabaseClient.auth.signOut();
  }
}
