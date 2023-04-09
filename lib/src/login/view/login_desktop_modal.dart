import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/listings/listings_page.dart';
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
    ).whenComplete(() => dialogIsShowing = false);
    setState(() {
      dialogIsShowing = true;
    });
  }

  void closeLogin(BuildContext context) {
    if (dialogIsShowing) {
      Navigator.of(context, rootNavigator: true).pop();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      closeLogin(widget.parentContext);
    });
    super.deactivate();
  }

  @override
  void activate() {
    super.activate();
  }

  @override
  Widget build(BuildContext context) {
    return const ListingsPage();
  }
}
