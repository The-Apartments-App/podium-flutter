import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/resident_portal/building_amenities/building_amenities.dart';
import 'package:podium/src/resident_portal/coming_soon/coming_soon.dart';
import 'package:podium/src/resident_portal/user_documents/user_documents.dart';
import 'package:podium/src/resident_portal/user_home/home.dart';
import 'package:podium/src/resident_portal/user_payments/user_payments.dart';
import 'package:podium/src/resident_portal/user_settings/user_settings.dart';
import 'package:podium/src/service_requests/service_requests.dart';

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
  bool userIsABoss = false;
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final ownerIds = ['kmbvxRaTSBfcf8Xk2CwstCpNQXp1'];
    if (ownerIds.contains(user.id)) {
      setState(() {
        userIsABoss = true;
      });
    }
    if (user.isEmpty) {
      setState(() {
        userIsABoss = false;
      });
    }
    debugPrint('userIsABoss: $userIsABoss');
    final residentRoutes = {
      '/': (context) => const ComingSoon(),
      '/home': (context) => HomePage(bossMode: userIsABoss),
      '/userPayments': (context) => const PaymentsPage(),
      '/userDocuments': (context) => const DocumentsPage(),
      '/userSettings': (context) => const UserSettingsPage(),
      '/serviceRequest': (context) => const ServiceRequestPage(),
      '/buildingAmenities': (context) => const BuildingAmenitiesPage(),
    };

    final ownerRoutes = {
      '/': (context) => const ComingSoon(),
      '/home': (context) => HomePage(bossMode: userIsABoss),
      '/ownerUserProfile': (context) => const Text('OWNER USER PROFILE'),
      '/ownerLedgers': (context) => const Text('OWNER LEDGERS PAGE'),
      '/ownerBuildingInfo': (context) => const Text('OWNER BUILDING INFO PAGE'),
      '/ownerBuildingInspections': (context) =>
          const Text('OWNER BUILDING INSPECTIONS PAGE'),
    };
    debugPrint('2b. APPVIEW BUILT - MaterialApp is created here');
    return MaterialApp(
      theme: appTheme,
      initialRoute: '/',
      routes: userIsABoss ? ownerRoutes : residentRoutes,
    );
  }
}
