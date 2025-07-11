import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/entities/auth_params/register_params.dart';
import 'package:invoice_app/pages/auth/login_screen.dart';
import 'package:invoice_app/pages/auth/riverpod/auth_provider.dart';
import 'package:invoice_app/pages/auth/riverpod/register_screen_provider.dart';
import 'package:invoice_app/pages/auth/widget/auth_form_widget.dart';
import 'package:invoice_app/utils/extensions.dart';
import 'package:invoice_app/widgets/button.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenAuthProvider(context, ref);
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
                  AuthFormWidget(
                    emailController: ref.watch(registerEmailControllerProvider),
                    isObscure: ref.watch(registerObscureTextProvider),
                    onVisibilityIconClicked: () {
                      ref
                          .watch(registerObscureTextProvider.notifier)
                          .update((state) => !state);
                    },
                    passwordController: ref.watch(
                      registerPasswordControllerProvider,
                    ),
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
                            child: Button(
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
    final email = ref.watch(registerEmailControllerProvider).text.trim();
    final password = ref.watch(registerPasswordControllerProvider).text.trim();
    final registerParams = RegisterParams(email: email, password: password);

    ref.read(authProvider.notifier).register(registerParams: registerParams);
  }

  void navigateToLoginScreen(BuildContext context) {
    final route = MaterialPageRoute(builder: (context) => const LoginScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  void listenAuthProvider(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next is AsyncData) {
        switch (next.value) {
          case AuthState.registered:
            ref.watch(registerEmailControllerProvider).clear();
            ref.watch(registerPasswordControllerProvider).clear();
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
