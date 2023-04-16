import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/home/home.dart';
import 'package:podium/src/login/login.dart';

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({super.key, required this.parentContext});
  final BuildContext parentContext;

  @override
  State<LoginMobilePage> createState() => LoginMobilePageState();
}

class LoginMobilePageState extends State<LoginMobilePage> {
  bool bottomSheetIsShowing = false;
  void showLogin(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: widget.parentContext,
      builder: (_) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BlocProvider(
            create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
            child: ListView(
              shrinkWrap: true,
              children: const [
                LoginForm(),
              ],
            ),
          ),
        );
      },
    );
  }

  void closeLogin(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLogin(widget.parentContext);
    });
  }

  @override
  void deactivate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      closeLogin(widget.parentContext);
    });
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
