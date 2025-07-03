import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(ThemeData.light());

  void changeTheme() {
    if (state == ThemeData.dark()) {
      state = ThemeData.light();
    } else {
      state = ThemeData.dark();
    }
  }
}
