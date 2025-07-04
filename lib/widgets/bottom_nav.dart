import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/riverpod/bottom_nav_index_provider.dart';

class BottomNav extends ConsumerWidget {
  final void Function() onHomeClicked;
  final void Function() onInvoiceClicked;
  final void Function() onSettingClicked;
  final void Function() onTransactionClicked;
  const BottomNav({
    super.key,
    required this.onHomeClicked,
    required this.onSettingClicked,
    required this.onTransactionClicked,
    required this.onInvoiceClicked,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final bottomNavWatch = ref.watch(bottomNavIndexProvider);
          return SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: onHomeClicked,
                  color: (bottomNavWatch == 0) ? Colors.blue : Colors.grey,
                  icon: const Icon(Icons.home, size: 28),
                ),
                IconButton(
                  onPressed: onInvoiceClicked,
                  color: (bottomNavWatch == 1) ? Colors.blue : Colors.grey,
                  icon: const Icon(Icons.receipt_long, size: 28),
                ),
                IconButton(
                  onPressed: onTransactionClicked,
                  color: (bottomNavWatch == 2) ? Colors.blue : Colors.grey,
                  icon: const Icon(Icons.account_balance_wallet, size: 28),
                ),
                IconButton(
                  onPressed: onSettingClicked,
                  color: (bottomNavWatch == 3) ? Colors.blue : Colors.grey,
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
