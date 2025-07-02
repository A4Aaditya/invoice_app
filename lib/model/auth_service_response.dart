import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServiceResponse {
  final Session? session;
  final User? user;
  final String message;
  final String? statusCode;
  final String? code;

  AuthServiceResponse({
    this.session,
    this.user,
    this.message = "Something went wrong",
    this.statusCode,
    this.code,
  });
}
