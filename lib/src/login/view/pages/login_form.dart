import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/src/login/cubit/login_cubit.dart';
import 'package:podium/src/login/view/pages/login_email_screen.dart';
import 'package:podium/src/login/view/pages/login_password_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
        // Here you can handle other state.status cases if needed
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return state.emailIsValid == false
              ? const LoginEmailScreen()
              : LoginPasswordScreen(
                  returnToEmail: () {
                    context.read<LoginCubit>().returnToEmail();
                  },
                );
        },
      ),
    );
  }
}
