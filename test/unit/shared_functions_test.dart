import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('routeToPage should navigate to the correct page',
      (WidgetTester tester) async {
    // Create a MaterialApp widget with a test navigator
    final navigatorKey = GlobalKey<NavigatorState>();
    final widget = MaterialApp(
      home: Builder(
        builder: (context) => PlatformElevatedButton(
          onPressed: () => context.push('/my_page'),
          child: const Text('Navigate'),
        ),
      ),
      navigatorKey: navigatorKey,
      routes: {
        '/my_page': (_) => const Scaffold(),
      },
    );

    // Build the widget and trigger the navigation
    await tester.pumpWidget(widget);
    await tester.tap(find.text('Navigate'));
    await tester.pumpAndSettle();

    // Check that the navigator pushed the correct route
    expect(navigatorKey.currentState!.canPop(), isTrue);
  });
}
