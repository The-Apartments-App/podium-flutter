import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/home/home.dart';
import 'package:podium/src/login/login.dart';

class LoginDesktopModal extends StatefulWidget {
  const LoginDesktopModal({super.key, required this.parentContext});
  final BuildContext parentContext;

  @override
  State<LoginDesktopModal> createState() => _LoginDesktopModalState();
}

class _LoginDesktopModalState extends State<LoginDesktopModal> {
  bool dialogIsShowing = false;
  void showLogin(BuildContext context) {
    showDialog<void>(
      context: widget.parentContext,
      builder: (_) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: Wrap(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: SizedBox(
                      width: 575,
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 400),
                        child: const LoginForm(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void closeLogin(BuildContext context) {
    // if (Navigator.of(context, rootNavigator: true).canPop()) {
    //   Navigator.of(context).pop();
    // }
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
