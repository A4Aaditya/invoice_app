import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/entities/auth_params/login_params.dart';
import 'package:invoice_app/pages/auth/riverpod/auth_provider.dart';
import 'package:invoice_app/pages/auth/widget/auth_form_widget.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/pages/auth/register_screen.dart';
import 'package:invoice_app/pages/auth/riverpod/login_screen_provider.dart';
import 'package:invoice_app/utils/extensions.dart';
import 'package:invoice_app/widgets/button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenAuthProvider(context, ref);

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

                  AuthFormWidget(
                    emailController: ref.watch(loginEmailControllerProvider),
                    isObscure: ref.watch(loginObscureTextProvider),
                    onVisibilityIconClicked: () {
                      ref
                          .read(loginObscureTextProvider.notifier)
                          .update((state) => !state);
                    },
                    passwordController: ref.watch(
                      loginPasswordControllerProvider,
                    ),
                  ),

                  const SizedBox(height: 24),

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
                              onPressed: () => onSignInTap(ref),
                              child: Text(context.i18n.loginText),
                            ),
                          ),

                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context.i18n.loginScreenDontAccountText),
                              TextButton(
                                onPressed: () => onSignupTap(context),
                                child: Text(
                                  context.i18n.signupText,
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
      backgroundColor: Colors.grey[100],
    );
  }

  void onSignupTap(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (context) {
        return const RegisterScreen();
      },
    );
    Navigator.push(context, route);
  }

  Future<void> onSignInTap(WidgetRef ref) async {
    final email = ref.read(loginEmailControllerProvider).text.trim();
    final password = ref.read(loginPasswordControllerProvider).text.trim();
    final loginParams = LoginParams(password: password, email: email);

    ref.read(authProvider.notifier).login(loginParams: loginParams);
  }

  void listenAuthProvider(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (next is AsyncData) {
        switch (next.value) {
          case AuthState.authentic:
            ref.watch(loginEmailControllerProvider).clear();
            ref.watch(loginPasswordControllerProvider).clear();
            navigateToDashboard(context);
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

  void navigateToDashboard(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (context) => const DashboardScreen(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
