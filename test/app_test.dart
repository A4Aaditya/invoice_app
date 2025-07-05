import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoice_app/app.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/pages/splash_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

Future<void> main() async {
  final dir = await Directory.systemTemp.createTemp();
  Hive.init(dir.path);
  await Hive.openBox('settingsBox');
  setUpAll(() async {
    final mockClient = MockSupabaseClient();
    GetIt.instance.registerSingleton<SupabaseClient>(mockClient);
  });

  setUp(() async {
    final mockClient = GetIt.instance.get<SupabaseClient>();
    when(() => mockClient.auth).thenReturn(MockGoTrueClient());
  });
  testWidgets('Render Material App', (WidgetTester tester) async {
    final mockClient = GetIt.instance.get<SupabaseClient>();
    final mockAuth = mockClient.auth;
    when(() => mockAuth.currentUser).thenReturn(null);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump(const Duration(seconds: 4));
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Render Splash Screen', (WidgetTester tester) async {
    final mockClient = GetIt.instance.get<SupabaseClient>();
    final mockAuth = mockClient.auth;
    when(() => mockAuth.currentUser).thenReturn(null);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump(const Duration(seconds: 4));
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('Render Dashoard Screen', (WidgetTester tester) async {
    final mockClient = GetIt.instance.get<SupabaseClient>();
    final result = User(
      id: '1',
      appMetadata: {},
      userMetadata: {},
      aud: 'public',
      createdAt: DateTime.now().toIso8601String(),
    );
    final mockAuth = mockClient.auth;
    when(() => mockAuth.currentUser).thenReturn(result);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump(const Duration(seconds: 4));
    expect(find.byType(DashboardScreen), findsOneWidget);
  });
}
