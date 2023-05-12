import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podium/shared/shared_components.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  testWidgets(
    'Test LinkedInLink widget',
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
    },
  );
}