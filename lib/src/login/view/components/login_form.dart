import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/src/login/cubit/login_cubit.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/pages/login_main_screen.dart';
import 'package:podium/src/login/view/pages/login_password_screen.dart';
import 'package:podium/src/login/view/pages/login_phone_code_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool emailIsEntered = false;
  bool phoneIsEntered = false;

  void returnToMain() {
    debugPrint('returnToMain is called in login_form.dart');
    setState(() {
      emailIsEntered = false;
      phoneIsEntered = false;
    });
    context.read<LoginCubit>().returnToMain();
  }

  Widget correctPage() {
    if (emailIsEntered) {
      return LoginPasswordScreen(returnToMain: returnToMain);
    } else if (phoneIsEntered) {
      return PhoneNumberCodeScreen(returnToMain: returnToMain);
    } else {
      return const LoginMainScreen();
    }
  }

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
        } else if (state.status.isSuccess) {
          debugPrint('state.status.isSuccess == true');
          Navigator.of(context).maybePop();
        } else if (state.emailIsEntered == true) {
          debugPrint('state.emailIsEntered == true');
          setState(() {
            emailIsEntered = true;
          });
        } else if (state.phoneIsEntered == true) {
          debugPrint('state.phoneIsEntered == true');
          setState(() {
            phoneIsEntered = true;
          });
        }
      },
      child: correctPage(),
    );
  }
}
