import 'package:caries_scan_app/main.dart';
import 'package:caries_scan_app/presentation/pages/welcome.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders splash and welcome screen properly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    // Verify initial render
    expect(find.byType(MyApp), findsOneWidget);

    // Pump timer for splash
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify Welcome screen is presented
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);
  });
}
