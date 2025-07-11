import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginEmailControllerProvider = Provider((ref) {
  return TextEditingController();
});

final loginPasswordControllerProvider = Provider((ref) {
  return TextEditingController();
});

final loginObscureTextProvider = StateProvider((ref) {
  return true;
});
