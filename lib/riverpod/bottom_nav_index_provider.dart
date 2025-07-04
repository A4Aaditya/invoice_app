import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavIndexNotifier extends StateNotifier<int> {
  BottomNavIndexNotifier() : super(0);

  void changeIndex(int index) {
    if (index == state) return;
    state = index;
  }
}

final bottomNavIndexProvider =
    StateNotifierProvider<BottomNavIndexNotifier, int>((ref) {
      return BottomNavIndexNotifier();
    });
