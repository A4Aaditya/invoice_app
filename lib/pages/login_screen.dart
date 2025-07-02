import 'package:flutter/material.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:invoice_app/utils/snackbar.dart';
import 'package:invoice_app/widgets/button.dart';
import 'package:invoice_app/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: ListView(
        children: [
          InputField(controller: emailController),
          InputField(controller: passwordController),
          Button(onPressed: onSiginTap, child: const Text("Login")),
        ],
      ),
    );
  }

  Future<void> onSiginTap() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final response = await AuthService().signinWithPassword(
      password: password,
      email: email,
    );
    if (response.user != null && response.session != null) {
      final route = MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      );
      if (!mounted) return;
      Navigator.pushReplacement(context, route);
    } else {
      if (!mounted) return;
      SnackbarHelper.showError(context, response.message);
    }
  }
}
