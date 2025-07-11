import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginControllers>((
  ref,
) {
  final text = kDebugMode ? 'nitishk72@gmail.com' : '';
  final emailController = TextEditingController(text: text);
  final passwordController = TextEditingController(text: text);
  final controller = LoginControllers(
    emailController: emailController,
    passwordController: passwordController,
  );
  return LoginNotifier(controller);
});

class LoginNotifier extends StateNotifier<LoginControllers> {
  LoginNotifier(super.controller);

  void toggle() {
    state = state.togglePasswordVisibility();
  }

  void reset() {
    state.emailController.clear();
    state.passwordController.clear();
  }
}

class LoginControllers {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool passwordObscureText;

  LoginControllers({
    required this.emailController,
    required this.passwordController,
    this.passwordObscureText = true,
  });

  LoginControllers togglePasswordVisibility() {
    return LoginControllers(
      emailController: emailController,
      passwordController: passwordController,
      passwordObscureText: !passwordObscureText,
    );
  }
}
