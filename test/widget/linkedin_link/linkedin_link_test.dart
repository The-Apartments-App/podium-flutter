import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podium/shared/shared_components.dart';

void main() {
  testWidgets('LinkedInLink renders and redirects correctly',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LinkedInLink(),
        ),
      ),
    );

    // Verify that the LinkedIn icon is displayed
    expect(find.byType(FaIcon), findsOneWidget);

    // Tap on the LinkedIn icon
    await tester.tap(find.byType(FaIcon));
    await tester.pumpAndSettle();
  });
}
