import 'package:flutter/material.dart';
import 'package:invoice_app/utils/extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(context.i18n.homePageName)));
  }
}
