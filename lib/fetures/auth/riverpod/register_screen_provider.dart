import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerProvider =
    StateNotifierProvider<LoginNotifier, RegisterControllers>((ref) {
      final text = kDebugMode ? 'nitishk72@gmail.com' : '';
      final emailController = TextEditingController(text: text);
      final passwordController = TextEditingController(text: text);
      final controller = RegisterControllers(
        emailController: emailController,
        passwordController: passwordController,
      );
      return LoginNotifier(controller);
    });

class LoginNotifier extends StateNotifier<RegisterControllers> {
  LoginNotifier(super.controller);

  void toggle() {
    state = state.togglePasswordVisibility();
  }

  void reset() {
    state.emailController.clear();
    state.passwordController.clear();
  }
}

class RegisterControllers {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool passwordObscureText;

  RegisterControllers({
    required this.emailController,
    required this.passwordController,
    this.passwordObscureText = true,
  });

  RegisterControllers togglePasswordVisibility() {
    return RegisterControllers(
      emailController: emailController,
      passwordController: passwordController,
      passwordObscureText: !passwordObscureText,
    );
  }
}
