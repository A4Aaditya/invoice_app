import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/fetures/dashboard/riverpod/bottom_nav_index_provider.dart';
import 'package:invoice_app/fetures/dashboard/riverpod/dashboard_provider.dart';
import 'package:invoice_app/widgets/core/custom_bottom_nav_bar.dart';

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
      bottomNavigationBar: CustomottomNavigationBar(
        onTabChange: (index) {
          bottomNavRead.changeIndex(index);
        },
      ),
    );
  }
}
