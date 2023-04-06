import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/listings/listings_page.dart';
import 'package:podium/src/login/login.dart';

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({super.key});

  @override
  State<LoginMobilePage> createState() => LoginMobilePageState();
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
PersistentBottomSheetController? controller;
bool bottomSheetIsShowing = false;

class LoginMobilePageState extends State<LoginMobilePage> {
  void showLogin(BuildContext context) {
    controller =
        scaffoldKey.currentState?.showBottomSheet((BuildContext context) {
      return BlocProvider(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: const LoginForm(),
      );
    });
    bottomSheetIsShowing = true;
  }

  void closeLogin() {
    if (controller != null) {
      controller?.close();
      controller = null;
      bottomSheetIsShowing = false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLogin(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      closeLogin();
    });
  }

  @override
  void activate() {
    super.activate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: const ListingsPage(),
      ),
    );
  }
}
