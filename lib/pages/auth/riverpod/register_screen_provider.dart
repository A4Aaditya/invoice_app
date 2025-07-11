import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerEmailControllerProvider = Provider((ref) {
  return TextEditingController();
});

final registerPasswordControllerProvider = Provider((ref) {
  return TextEditingController();
});

final registerObscureTextProvider = StateProvider((ref) {
  return true;
});
