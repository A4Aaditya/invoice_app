import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/fetures/auth/auth_entities/register_params.dart';
import 'package:invoice_app/fetures/auth/login_screen.dart';
import 'package:invoice_app/fetures/auth/riverpod/auth_provider.dart';
import 'package:invoice_app/fetures/auth/riverpod/register_screen_provider.dart';
import 'package:invoice_app/fetures/auth/widget/auth_form_widget.dart';
import 'package:invoice_app/utils/extensions.dart';
import 'package:invoice_app/widgets/core/custom_button.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenAuthProvider(context, ref);

    final registerState = ref.watch(registerProvider);
    final authState = ref.watch(authProvider);
    final registerNotifier = ref.read(registerProvider.notifier);
    final isLoading = authState.isLoading;

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
                    context.i18n.createAccount,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  AuthForm(
                    enabled: isLoading,
                    emailController: registerState.emailController,
                    passwordController: registerState.passwordController,
                    isObscure: registerState.passwordObscureText,
                    onVisibilityIconClicked: registerNotifier.toggle,
                  ),
                  const SizedBox(height: 16),

                  // const SizedBox(height: 24),
                  Consumer(
                    builder: (context, ref, child) {
                      if (ref.watch(authProvider).isLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              onPressed: () => register(ref),
                              child: Text(context.i18n.register),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context.i18n.registerScreenText),
                              TextButton(
                                onPressed: () => navigateToLoginScreen(context),
                                child: Text(
                                  context.i18n.loginText,
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register(WidgetRef ref) async {
    final registerRef = ref.watch(registerProvider);
    final email = registerRef.emailController.text.trim();
    final password = registerRef.passwordController.text.trim();
    final registerParams = RegisterParams(password: password, email: email);
    ref.read(authProvider.notifier).register(registerParams: registerParams);
  }

  void navigateToLoginScreen(BuildContext context) {
    final route = MaterialPageRoute(builder: (context) => const LoginScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  void listenAuthProvider(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(registerProvider.notifier);

    ref.listen(authProvider, (previous, next) {
      if (next is AsyncData) {
        switch (next.value) {
          case AuthState.registered:
            loginNotifier.reset();
            navigateToLoginScreen(context);
            break;

          case AuthState.unauthentic:
            break;
          default:
            break;
        }
      }

      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${next.error}')));
      }
    });
  }
}
