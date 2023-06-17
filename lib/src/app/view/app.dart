import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/app/routes/routes.dart';
import 'package:podium/theme.dart';

class PodiumApp extends StatelessWidget {
  const PodiumApp({
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
  RouterClass router = RouterClass();

  @override
  Widget build(BuildContext context) {
    debugPrint('2b. APPVIEW - MaterialApp.router built here');
    return MaterialApp.router(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.goRouter.routeInformationParser,
      routerDelegate: router.goRouter.routerDelegate,
      routeInformationProvider: router.goRouter.routeInformationProvider,
    );
  }
}
