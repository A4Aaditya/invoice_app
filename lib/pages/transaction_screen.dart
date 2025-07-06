import 'package:flutter/material.dart';
import 'package:invoice_app/utils/extensions.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(context.i18n.transaction)));
  }
}
