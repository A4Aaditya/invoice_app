import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(ThemeData.light()) {
    getTheme();
  }

  final box = Hive.box("settingsBox");

  Future<void> changeTheme() async {
    if (state == ThemeData.dark()) {
      await setTheme(isDarkMode: false);
      state = ThemeData.light();
    } else {
      await setTheme(isDarkMode: true);
      state = ThemeData.dark();
    }
  }

  Future<void> setTheme({required bool isDarkMode}) async {
    try {
      await box.put("theme", isDarkMode);
    } catch (e) {
      log("catch while setting local storage theme $e");
    }
  }

  void getTheme() {
    try {
      final isDarkModel = box.get("theme");
      if (isDarkModel == null) {
        state = ThemeData.light();
      } else if (isDarkModel) {
        state = ThemeData.dark();
      } else {
        state = ThemeData.light();
      }
    } catch (e) {
      log("catch while getting local storage theme $e");
    }
  }
}
