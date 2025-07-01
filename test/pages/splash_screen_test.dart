import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:invoice_app/i18n/app_localizations.dart';
import 'package:invoice_app/pages/splash_screen.dart';

void main() {
  Widget renderScreen() {
    return MaterialApp(
      home: SplashScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale('en'),
    );
  }

  testWidgets('Render Splash Screen', (WidgetTester tester) async {
    await tester.pumpWidget(renderScreen());
    expect(find.byType(SplashScreen), findsOneWidget);
  });
  testWidgets('Render Scaffold', (WidgetTester tester) async {
    await tester.pumpWidget(renderScreen());
    expect(find.byType(Scaffold), findsOneWidget);
  });
  testWidgets('Render Text', (WidgetTester tester) async {
    final delegate = AppLocalizations.delegate;
    final localizations = await delegate.load(const Locale('en'));
    await tester.pumpWidget(renderScreen());
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(localizations.appName), findsOneWidget);
  });

  testWidgets('Render Text', (WidgetTester tester) async {
    final delegate = AppLocalizations.delegate;
    final localizations = await delegate.load(const Locale('en'));
    await tester.pumpWidget(renderScreen());
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(localizations.appName), findsOneWidget);
  });

  testWidgets('Should not contain any Button', (WidgetTester tester) async {
    await tester.pumpWidget(renderScreen());
    expect(find.byType(ElevatedButton), findsNothing);
  });
}
