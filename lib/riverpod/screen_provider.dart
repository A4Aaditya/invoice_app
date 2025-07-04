import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/entities/screen_entities.dart';
import 'package:invoice_app/pages/home_screen.dart';
import 'package:invoice_app/pages/invoice_scrren.dart';
import 'package:invoice_app/pages/setting_screen.dart';
import 'package:invoice_app/pages/transaction_screen.dart';
import 'package:invoice_app/riverpod/bottom_nav_index_provider.dart';

final screenProviderByIndex = Provider<ScreenEntities>((ref) {
  List<ScreenEntities> listOfScreen = [
    ScreenEntities(index: 0, screen: const HomeScreen()),
    ScreenEntities(index: 1, screen: const InvoiceScreen()),
    ScreenEntities(index: 2, screen: const TransactionScreen()),
    ScreenEntities(index: 3, screen: const SettingScreen()),
  ];
  final index = ref.watch(bottomNavIndexProvider);

  final screenEntities = listOfScreen.singleWhere((e) {
    return e.index == index;
  });
  return screenEntities;
});
