import 'package:flutter/gestures.dart';
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

    final loginState = ref.watch(loginProvider);
    final authState = ref.watch(authProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    final isLoading = authState.isLoading;

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
                  Icon(
                    Icons.lock_outline,
                    size: 120,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.i18n.loginRegisterScreenWelcomeText,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.i18n.loginScreenLoginAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  AuthForm(
                    emailController: loginState.emailController,
                    enabled: !ref.watch(authProvider).isLoading,
                    isObscure: ref.watch(loginProvider).passwordObscureText,
                    onVisibilityIconClicked: () {
                      loginNotifier.toggle();
                    },
                    passwordController: loginState.passwordController,
                  ),

                  const SizedBox(height: 24),

                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          isDisabled: isLoading,
                          onPressed: () => onSignInTap(ref),
                          child: Text(context.i18n.loginText),
                        ),
                      ),

                      const SizedBox(height: 16),

                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(
                            context,
                          ).style.copyWith(fontSize: 16),
                          children: [
                            TextSpan(
                              text:
                                  '${context.i18n.loginScreenDontAccountText} ',
                            ),
                            TextSpan(
                              text: context.i18n.signupText,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = isLoading
                                    ? null
                                    : () => onSignupTap(context),
                            ),
                          ],
                        ),
                      ),
                    ],
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
    final loginRef = ref.watch(loginProvider);
    final email = loginRef.emailController.text.trim();
    final password = loginRef.passwordController.text.trim();
    final loginParams = LoginParams(password: password, email: email);
    ref.read(authProvider.notifier).login(loginParams: loginParams);
  }

  void listenAuthProvider(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginProvider.notifier);
    ref.listen(authProvider, (previous, next) {
      if (next is AsyncData) {
        switch (next.value) {
          case AuthState.authentic:
            loginNotifier.reset();
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
