import 'package:flutter_test/flutter_test.dart';
import 'package:invoice_app/entities/auth_params/register_params.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockSession extends Mock implements Session {}

class MockUser extends Mock implements User {}

class MockAuthResponse extends Mock implements AuthResponse {}

void main() {
  late final MockSupabaseClient mockSupabaseClient;
  late final AuthService authService;
  late final MockGoTrueClient mockAuth;

  setUpAll(() {
    mockSupabaseClient = MockSupabaseClient();
    mockAuth = MockGoTrueClient();
    authService = AuthService(supabaseClient: mockSupabaseClient);
    when(() => mockSupabaseClient.auth).thenReturn(mockAuth);
  });

  test("register with email and password", () async {
    final params = RegisterParams(
      email: "mockUser@gmail.com",
      password: "password",
    );
    final mockSession = MockSession();
    final mockuser = MockUser();
    final mockResponse = MockAuthResponse();
    when(() => mockResponse.user).thenReturn(mockuser);
    when(() => mockuser.email).thenReturn("mockUser@gmail.com");
    when(() => mockResponse.session).thenReturn(mockSession);
    when(
      () => mockAuth.signUp(password: params.password, email: params.email),
    ).thenAnswer((_) async => mockResponse);
    final result = await authService.registerEmailPassword(params);

    expect(result.user, mockuser);
    expect(result.session, mockSession);
    expect(result.user?.email, "mockUser@gmail.com");
  });
}
