import 'package:flutter/material.dart';
import 'package:invoice_app/pages/auth/login_screen.dart';
import 'package:invoice_app/utils/extensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      final route = MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
      if (!mounted) return;
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.i18n.appName,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 80,
            ),
          ],
        ),
      ),
    );
  }
}
