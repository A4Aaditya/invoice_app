import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterParams {
  final String? email;
  final String? phone;
  final String password;
  final String? emailRedirectTo;
  final Map<String, dynamic>? data;
  final String? captchaToken;
  final OtpChannel channel = OtpChannel.sms;

  RegisterParams({
    required this.email,
    required this.password,
    this.captchaToken,
    this.data,
    this.emailRedirectTo,
    this.phone,
  });
}
