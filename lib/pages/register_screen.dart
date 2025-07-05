import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:invoice_app/entities/auth_params/register_params.dart';
import 'package:invoice_app/model/service_response.dart';
import 'package:invoice_app/pages/login_screen.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:invoice_app/utils/extensions.dart';
import 'package:invoice_app/utils/snackbar.dart';
import 'package:invoice_app/widgets/button.dart';
import 'package:invoice_app/widgets/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person_add_alt_1,
                    size: 64,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.i18n.registerScreeTitle,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  InputField(
                    controller: emailController,
                    hintText: context.i18n.registerScreenHintEmail,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    controller: passwordController,
                    hintText: context.i18n.registerScreenHintPassword,
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
                      onPressed: register,
                      child: Text(
                        context.i18n.registerScreenRegisterButtonName,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.i18n.registerScreenText),
                      TextButton(
                        onPressed: navigateToLoginScreen,
                        child: Text(context.i18n.registerScreenLoginButtonName),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final registerParams = RegisterParams(email: email, password: password);
    final authService = GetIt.instance.get<AuthService>();

    final response = await authService.registerEmailPassword(registerParams);
    if (!mounted) return;
    switch (response) {
      case SucessResult<User, String>():
        SnackbarHelper.showSuccess(
          context,
          "User created successfully! Confirmation link sent to your register mail.",
        );
        navigateToLoginScreen();
      case FailureResult<User, String>(:final error):
        SnackbarHelper.showError(context, error);
    }
  }

  void navigateToLoginScreen() {
    final route = MaterialPageRoute(builder: (context) => const LoginScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
