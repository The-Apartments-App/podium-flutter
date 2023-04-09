import 'package:authentication_repo/authentication_repo.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
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
      home: const Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color(0xFFFFFFFF),
        //   foregroundColor: const Color(0xFF03795D),
        //   shadowColor: Colors.transparent,
        //   leading: const PodiumLogo(),
        // ),
        body: FlowBuilder<AppPage>(
          state: AppPage.userLogin,
          onGeneratePages: onGenerateAppViewPages,
        ),
      ),
    );
  }
}
