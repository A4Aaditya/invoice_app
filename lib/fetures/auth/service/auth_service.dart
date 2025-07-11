import 'package:invoice_app/fetures/auth/auth_entities/login_params.dart';
import 'package:invoice_app/core/params/no_params.dart';
import 'package:invoice_app/fetures/auth/auth_entities/register_params.dart';
import 'package:invoice_app/model/service_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabaseClient;
  AuthService({required this.supabaseClient});

  Future<ServiceResult<User, String>> signinWithPassword(
    LoginParams loginParams,
  ) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: loginParams.password,
        email: loginParams.email,
      );

      if (response.user == null) {
        throw Exception("User not found");
      }

      return SucessResult(response.user!);
    } on AuthException catch (e) {
      return FailureResult(e.message, exceptions: e);
    } on Exception catch (e) {
      return FailureResult("User not found", exceptions: e);
    }
  }

  Future<ServiceResult<User, String>> registerEmailPassword(
    RegisterParams registerParams,
  ) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: registerParams.password,
        email: registerParams.email,
      );

      if (response.user == null) {
        throw Exception("User not found");
      }

      return SucessResult(response.user!);
    } on AuthException catch (e) {
      return FailureResult(e.message, exceptions: e);
    } on Exception catch (e) {
      return FailureResult("User not found", exceptions: e);
    }
  }

  Future<void> signOut(NoParams noParams) async {
    await supabaseClient.auth.signOut();
  }
}
