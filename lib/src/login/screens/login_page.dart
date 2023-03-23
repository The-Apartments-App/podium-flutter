import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: SizedBox(
            width: MediaQuery.of(context).size.width, child: const LoginForm()),
      ),
    );
  }
}
