import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, String>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier() : super("en") {
    getLanguagePreference();
  }

  final box = Hive.box("settingsBox");

  Future<void> setLanguage(String language) async {
    await storeLanguagePreference(language);
    state = language;
  }

  Future<void> storeLanguagePreference(String language) async {
    try {
      await box.put("lang", language);
    } catch (e) {
      log("catch while putting language preference in hive $e");
    }
  }

  void getLanguagePreference() {
    try {
      final lang = box.get("lang");
      state = lang ?? "en";
    } catch (e) {
      log("catch while getting language preference in hive $e");
    }
  }
}
