class LoginParams {
  final String email;
  final String? phone;
  final String password;
  final String? captchaToken;

  LoginParams({
    required this.password,
    required this.email,
    this.captchaToken,
    this.phone,
  });
}
