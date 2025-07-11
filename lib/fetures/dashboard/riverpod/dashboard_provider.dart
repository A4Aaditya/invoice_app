import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/fetures/dashboard/entities/screen_entities.dart';
import 'package:invoice_app/fetures/home/home_screen.dart';
import 'package:invoice_app/fetures/property/property_listing_screen.dart';
import 'package:invoice_app/fetures/settings/setting_screen.dart';
import 'package:invoice_app/fetures/dashboard/riverpod/bottom_nav_index_provider.dart';

final screenProviderByIndex = Provider<ScreenEntities>((ref) {
  List<ScreenEntities> listOfScreen = [
    ScreenEntities(index: 0, screen: const HomeScreen()),
    ScreenEntities(index: 1, screen: const PropertyListingScreen()),
    ScreenEntities(index: 2, screen: const Text('Get')),
    ScreenEntities(index: 3, screen: const SettingScreen()),
  ];
  final index = ref.watch(bottomNavIndexProvider);

  final screenEntities = listOfScreen.singleWhere((e) {
    return e.index == index;
  });
  return screenEntities;
});
