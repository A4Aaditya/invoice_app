import 'package:flutter/material.dart';
import 'package:invoice_app/widgets/button.dart';
import 'package:invoice_app/widgets/input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: ListView(
        children: [
          InputField(controller: emailController),
          InputField(controller: passwordController),
          Button(onPressed: register, child: const Text("Register")),
        ],
      ),
    );
  }

  Future<void> register() async {}
}
