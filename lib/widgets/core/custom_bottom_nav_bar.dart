import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/fetures/dashboard/riverpod/bottom_nav_index_provider.dart';

class CustomottomNavigationBar extends ConsumerWidget {
  final void Function(int index) onTabChange;
  const CustomottomNavigationBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final bottomNavWatch = ref.watch(bottomNavIndexProvider);
          return SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => onTabChange(0),
                  color: (bottomNavWatch == 0) ? primaryColor : secondaryColor,
                  icon: const Icon(Icons.home, size: 28),
                ),
                IconButton(
                  onPressed: () => onTabChange(1),
                  color: (bottomNavWatch == 1) ? primaryColor : secondaryColor,
                  icon: const Icon(Icons.hotel, size: 28),
                ),
                IconButton(
                  onPressed: () => onTabChange(2),
                  color: (bottomNavWatch == 2) ? primaryColor : secondaryColor,
                  icon: const Icon(Icons.account_balance_wallet, size: 28),
                ),
                IconButton(
                  onPressed: () => onTabChange(3),
                  color: (bottomNavWatch == 3) ? primaryColor : secondaryColor,
                  icon: const Icon(Icons.settings, size: 28),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
