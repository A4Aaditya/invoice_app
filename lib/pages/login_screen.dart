import 'package:flutter/material.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
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
    final supabaseClient = Supabase.instance.client;
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.session != null && response.user != null) {
        final route = MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        );
        if (!mounted) return;
        Navigator.pushReplacement(context, route);
      }
    } on AuthApiException catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.message);
    } catch (e) {
      print("on catch error ${e.toString()}");
    }
  }
}
