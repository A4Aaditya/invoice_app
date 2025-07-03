import 'package:flutter_test/flutter_test.dart';
import 'package:invoice_app/entities/auth_params/login_params.dart';
import 'package:invoice_app/entities/auth_params/register_params.dart';
import 'package:invoice_app/model/service_response.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockAuthException extends Mock implements AuthException {}

class MockException extends Mock implements Exception {}

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
    final mockuser = MockUser();
    final mockResponse = MockAuthResponse();
    when(() => mockResponse.user).thenReturn(mockuser);
    when(() => mockuser.email).thenReturn("mockUser@gmail.com");
    when(
      () => mockAuth.signUp(password: params.password, email: params.email),
    ).thenAnswer((_) async => mockResponse);
    final result = await authService.registerEmailPassword(params);

    if (result case SucessResult<User, String>(:final data)) {
      expect(data, mockuser);
      expect(data.email, "mockUser@gmail.com");
    }
  });

  test("When register method throw exception", () async {
    final params = RegisterParams(email: "", password: "password");
    final mockAuthException = MockAuthException();
    final mockException = MockException();

    when(() => mockAuthException.message).thenAnswer((_) => "User not found");

    when(
      () => mockAuth.signUp(password: params.password, email: params.email),
    ).thenThrow(mockAuthException);

    when(
      () => mockAuth.signUp(password: params.password, email: params.email),
    ).thenThrow(mockException);

    try {
      await authService.registerEmailPassword(params);
    } on AuthException catch (e) {
      expect(e, isA<FailureResult>());
      if (e case FailureResult<User, String>(:final error)) {
        expect(error, mockAuthException.message);
      }
    } on Exception catch (e) {
      expect(e, isA<FailureResult>());
      if (e case FailureResult<User, String>(:final error)) {
        expect(error, mockAuthException.message);
      }
    }
  });

  test("signin with email and password   ", () async {
    final params = LoginParams(password: "password", email: "mockUser@gmail");
    final mockuser = MockUser();
    final mockAuthResponse = MockAuthResponse();

    when(() => mockAuthResponse.user).thenReturn(mockuser);

    when(() => mockuser.email).thenReturn("mockUser@gmail");

    when(
      () => mockAuth.signInWithPassword(
        password: params.password,
        email: params.email,
      ),
    ).thenAnswer((_) async => mockAuthResponse);

    final result = await authService.signinWithPassword(params);

    if (result case SucessResult<User, String>(:final data)) {
      expect(data, mockuser);
    }
  });
}
