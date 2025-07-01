import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invoice_app/app.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/pages/splash_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  late MockSupabaseClient mockClient;

  setUp(() {
    mockClient = MockSupabaseClient();
    when(() => mockClient.auth).thenReturn(MockGoTrueClient());
  });
  testWidgets('Render Material App', (WidgetTester tester) async {
    final mockAuth = mockClient.auth;
    when(() => mockAuth.currentUser).thenReturn(null);
    await tester.pumpWidget(MyApp(client: mockClient));
    await tester.pump(const Duration(seconds: 4));
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Render Splash Screen', (WidgetTester tester) async {
    final mockAuth = mockClient.auth;
    when(() => mockAuth.currentUser).thenReturn(null);
    await tester.pumpWidget(MyApp(client: mockClient));
    await tester.pump(const Duration(seconds: 4));
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('Render Dashoard Screen', (WidgetTester tester) async {
    final result = User(
      id: '1',
      appMetadata: {},
      userMetadata: {},
      aud: 'public',
      createdAt: DateTime.now().toIso8601String(),
    );
    final mockAuth = mockClient.auth;
    when(() => mockAuth.currentUser).thenReturn(result);
    await tester.pumpWidget(MyApp(client: mockClient));
    await tester.pump(const Duration(seconds: 4));
    expect(find.byType(DashboardScreen), findsOneWidget);
  });
}
