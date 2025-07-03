import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/riverpod/bottom_nav_index_provider.dart';
import 'package:invoice_app/riverpod/screen_provider.dart';
import 'package:invoice_app/widgets/bottom_nav.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomNavRead = ref.read(bottomNavIndexProvider.notifier);

    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref.watch(screenProviderByIndex).screen;
        },
      ),
      bottomNavigationBar: BottomNav(
        onHomeClicked: () {
          bottomNavRead.changeIndex(0);
        },

        onInvoiceClicked: () {
          bottomNavRead.changeIndex(1);
        },
        onTransactionClicked: () {
          bottomNavRead.changeIndex(2);
        },

        onSettingClicked: () {
          bottomNavRead.changeIndex(3);
        },
      ),
    );
  }
}
