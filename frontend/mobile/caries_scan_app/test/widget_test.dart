import 'package:caries_scan_app/presentation/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Welcome screen renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomePage()));

    // Verify Welcome screen is presented
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);
  });
}
