import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:invoice_app/entities/auth_params/login_params.dart';
import 'package:invoice_app/model/service_response.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/pages/register_screen.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:invoice_app/utils/extensions.dart';
import 'package:invoice_app/utils/snackbar.dart';
import 'package:invoice_app/widgets/button.dart';
import 'package:invoice_app/widgets/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 72,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.i18n.loginRegisterScreenWelcomeText,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.i18n.loginScreenLoginAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  InputField(
                    controller: emailController,
                    hintText: context.i18n.loginScreenEmailText,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    controller: passwordController,
                    hintText: context.i18n.loginScreenPasswordText,
                    obscureText: obscure,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: Button(
                      onPressed: onSignInTap,
                      child: Text(context.i18n.loginScreenLoginButton),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.i18n.loginScreenDontAccountText),
                      TextButton(
                        onPressed: onSignupTap,
                        child: Text(
                          context.i18n.loginScreenSignupButton,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  void onSignupTap() {
    final route = MaterialPageRoute(
      builder: (context) {
        return const RegisterScreen();
      },
    );
    Navigator.push(context, route);
  }

  Future<void> onSignInTap() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final loginParams = LoginParams(password: password, email: email);
    final authService = GetIt.instance.get<AuthService>();
    final response = await authService.signinWithPassword(loginParams);
    if (!mounted) return;
    switch (response) {
      case SucessResult<User, String>():
        final route = MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        );

        Navigator.pushReplacement(context, route);
      case FailureResult<User, String>(error: final error):
        SnackbarHelper.showError(context, error);
    }
  }
}
