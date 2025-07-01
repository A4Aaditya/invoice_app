import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invoice_app/app.dart';
import 'package:invoice_app/pages/dashboard_screen.dart';
import 'package:invoice_app/pages/splash_screen.dart';

void main() {
  testWidgets('Render Material App', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Render Splash Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
