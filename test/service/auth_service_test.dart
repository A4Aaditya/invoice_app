import 'package:flutter_test/flutter_test.dart';
import 'package:invoice_app/entities/auth_params/register_params.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  late final MockSupabaseClient mockSupabaseClient;
  late final AuthService authService;
  late final MockGoTrueClient mockGoTrueClient;

  setUpAll(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    authService = AuthService(supabaseClient: mockSupabaseClient);
  });
  test("register with email when email is empty", () async {
    final params = RegisterParams(email: "", password: "password");
    final fakeResponse = await mockGoTrueClient.signUp(
      password: params.password,
      email: params.email,
    );

    final response = await authService.registerEmailPassword(params);

    expect(response.session, fakeResponse.session);
    expect(response.user, fakeResponse.user);
  });
}
