import 'package:flutter/material.dart';
import 'package:invoice_app/utils/extensions.dart';
import 'package:invoice_app/widgets/input_field.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.emailController,
    required this.isObscure,
    required this.onVisibilityIconClicked,
    required this.passwordController,
    this.enabled = true,
  });

  final bool isObscure;
  final bool enabled;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function() onVisibilityIconClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          enabled: enabled,
          controller: emailController,
          hintText: context.i18n.emailText,
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        const SizedBox(height: 16),
        InputField(
          enabled: enabled,
          controller: passwordController,
          hintText: context.i18n.passwordText,
          obscureText: isObscure,
          keyboardType: TextInputType.text,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
            onPressed: onVisibilityIconClicked,
          ),
        ),
      ],
    );
  }
}
