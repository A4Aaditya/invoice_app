import 'package:flutter/material.dart';
import 'package:invoice_app/pages/auth/login_screen.dart';
import 'package:invoice_app/utils/extensions.dart';

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
    return Scaffold(body: Center(child: Text(context.i18n.appName)));
  }
}
