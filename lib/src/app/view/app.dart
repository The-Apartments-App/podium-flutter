import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/blog_story_page/blog_story_page.dart';
import 'package:podium/src/home_page/home.dart';
import 'package:podium/src/owner_portal/owner_dashboard/owner_dashboard.dart';
import 'package:podium/src/resident_portal/building_amenities/building_amenities.dart';
import 'package:podium/src/resident_portal/user_documents/user_documents.dart';
import 'package:podium/src/resident_portal/user_payments/user_payments.dart';
import 'package:podium/src/resident_portal/user_settings/user_settings.dart';
import 'package:podium/src/service_requests/service_requests.dart';
import 'package:podium/src/splash_page/splash_page.dart';
import 'package:podium/theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    debugPrint('2a. APP IS RUNNING - AppBloc is provided');
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  bool userIsABoss = true;
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final ownerIds = ['kmbvxRaTSBfcf8Xk2CwstCpNQXp1'];
    // if (ownerIds.contains(user.id)) {
    //   setState(() {
    //     userIsABoss = true;
    //   });
    // }
    // if (user.isEmpty) {
    //   setState(() {
    //     userIsABoss = false;
    //   });
    // }

    MaterialPageRoute<dynamic> buildOwnerPageRoute(
      Widget page,
    ) {
      // Check if the current user has one of the allowed roles
      if (!userIsABoss) {
        // If the user's role is not allowed, navigate to a fallback page
        return MaterialPageRoute(
          builder: (_) => const HomePage(
            bossMode: false,
          ),
        );
      }

      // Otherwise, show the requested page
      return MaterialPageRoute(builder: (_) => page);
    }

    debugPrint('2b. APPVIEW BUILT - MaterialApp is created here');
    return MaterialApp(
      theme: appTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final blogId =
            // ignore: cast_nullable_to_non_nullable
            settings.arguments != null ? settings.arguments as String : '';
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashPage());
          case '/home':
            return MaterialPageRoute(
              builder: (_) => HomePage(
                bossMode: userIsABoss,
              ),
            );
          case '/blogs':
            return MaterialPageRoute(
              builder: (_) => BlogStoryPage(blogId: blogId),
            );
          case '/userPayments':
            return MaterialPageRoute(builder: (_) => const PaymentsPage());
          case '/userDocuments':
            return MaterialPageRoute(builder: (_) => const DocumentsPage());
          case '/userSettings':
            return MaterialPageRoute(builder: (_) => const UserSettingsPage());
          case '/serviceRequest':
            return MaterialPageRoute(
              builder: (_) => const ServiceRequestPage(),
            );
          case '/buildingAmenities':
            return MaterialPageRoute(
              builder: (_) => const BuildingAmenitiesPage(),
            );
          case '/ownerDashboard':
            return buildOwnerPageRoute(
              const OwnerDashboard(),
            );
          case '/ownerLedgers':
            return buildOwnerPageRoute(
              const Text('OWNER LEDGERS PAGE'),
            );
          case '/ownerBuildingInfo':
            return buildOwnerPageRoute(
              const Text('OWNER BUILDING INFO PAGE'),
            );
          case '/ownerBuildingInspections':
            return buildOwnerPageRoute(
              const Text('OWNER BUILDING INSPECTIONS PAGE'),
            );
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
      },
    );
  }
}
