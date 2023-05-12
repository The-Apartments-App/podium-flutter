import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/blog_story_page/blog_story_page.dart';
import 'package:podium/src/home_page/home.dart';
import 'package:podium/src/resident_portal/user_documents/user_documents.dart';
import 'package:podium/src/resident_portal/user_payments/user_payments.dart';
import 'package:podium/src/resident_portal/user_settings/user_settings.dart';
import 'package:podium/src/splash_page/splash_page.dart';

import '../../test_helpers.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthenticationRepository authenticationRepository;
  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  group('App widget', () {
    testWidgets('renders AppView', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );

      expect(find.byType(AppView), findsOneWidget);
    });

    testWidgets('navigates to SplashPage on initial route', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );

      expect(find.byType(SplashPage), findsOneWidget);
    });

    testWidgets('HomePage renders correctly', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(bossMode: false),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('BlogStoryPage renders correctly', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: BlogStoryPage(
            blogId: '420',
          ),
        ),
      );

      expect(find.byType(BlogStoryPage), findsOneWidget);
    });

    testWidgets('PaymentsPage renders correctly', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentsPage(),
        ),
      );

      expect(find.byType(PaymentsPage), findsOneWidget);
    });

    testWidgets('DocumentsPage renders correctly', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: DocumentsPage(),
        ),
      );

      expect(find.byType(DocumentsPage), findsOneWidget);
    });

    testWidgets('UserSettingsPage renders correctly', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: UserSettingsPage(),
        ),
      );

      expect(find.byType(UserSettingsPage), findsOneWidget);
    });
  });
}

class MockAuthenticationRepository extends Fake
    implements AuthenticationRepository {
  @override
  final currentUser = User.empty;

  @override
  Stream<User> get user => const Stream.empty();

  Future<void> logIn({required String username, required String password}) =>
      Future.value();

  @override
  Future<void> logOut() => Future.value();
}
