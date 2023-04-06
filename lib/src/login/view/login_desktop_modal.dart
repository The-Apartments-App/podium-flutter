import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/login_form.dart';

class LoginDesktopModal extends StatelessWidget {
  const LoginDesktopModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
      child: const Dialog(
        child: LoginForm(),
      ),
    );
  }
}
