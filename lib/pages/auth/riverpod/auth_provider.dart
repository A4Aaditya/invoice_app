import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:invoice_app/entities/auth_params/login_params.dart';
import 'package:invoice_app/entities/auth_params/no_params.dart';
import 'package:invoice_app/entities/auth_params/register_params.dart';
import 'package:invoice_app/model/service_response.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthState { loading, unauthentic, authentic, registered, logout }

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<AuthState> {
  final _authService = GetIt.instance.get<AuthService>();

  @override
  Future<AuthState> build() async {
    return AuthState.unauthentic;
  }

  Future<void> login({required LoginParams loginParams}) async {
    state = const AsyncValue.loading();

    final response = await _authService.signinWithPassword(loginParams);

    switch (response) {
      case SucessResult<User, String>():
        state = const AsyncValue.data(AuthState.authentic);

      case FailureResult<User, String>():
        state = const AsyncValue.data(AuthState.unauthentic);
    }
  }

  Future<void> logout({required NoParams noParams}) async {
    await _authService.signOut(noParams);
    state = const AsyncValue.data(AuthState.logout);
  }

  Future<void> register({required RegisterParams registerParams}) async {
    state = const AsyncValue.loading();

    final response = await _authService.registerEmailPassword(registerParams);

    switch (response) {
      case SucessResult<User, String>():
        state = const AsyncValue.data(AuthState.registered);
      case FailureResult<User, String>():
        state = const AsyncValue.data(AuthState.unauthentic);
    }
  }
}
