import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/listings/listings_page.dart';
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
      context: widget.parentContext,
      builder: (_) {
        return BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: const LoginForm(),
        );
      },
    ).whenComplete(() => bottomSheetIsShowing = false);
    setState(() {
      bottomSheetIsShowing = true;
    });
  }

  void closeLogin(BuildContext context) {
    if (bottomSheetIsShowing) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLogin(widget.parentContext);
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
      closeLogin(widget.parentContext);
    });
  }

  @override
  void activate() {
    super.activate();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('bottomSheetIsShowing: $bottomSheetIsShowing');
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: const ListingsPage(),
      ),
    );
  }
}
