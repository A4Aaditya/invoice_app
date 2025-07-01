import 'package:flutter/material.dart';
import 'package:invoice_app/utils/extensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(context.i18n.appName)));
  }
}
