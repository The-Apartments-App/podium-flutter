import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/building_amenities/view/building_amenities.dart';
import 'package:podium/src/coming_soon/view/coming_soon.dart';
import 'package:podium/src/home/home.dart';
import 'package:podium/src/service_requests/view/pages/service_request_page.dart';
import 'package:podium/src/user_documents/user_documents.dart';
import 'package:podium/src/user_payments/user_payments.dart';
import 'package:podium/src/user_settings/user_settings.dart';
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

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('2b. APPVIEW BUILT - MaterialApp is created here');
    return MaterialApp(
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const ComingSoon(),
        '/userHome': (context) => const HomePage(),
        '/userPayments': (context) => const PaymentsPage(),
        '/userDocuments': (context) => const DocumentsPage(),
        '/userSettings': (context) => const UserSettingsPage(),
        '/serviceRequest': (context) => const ServiceRequestPage(),
        '/buildingAmenities': (context) => const BuildingAmenitiesPage(),
      },
    );
  }
}
