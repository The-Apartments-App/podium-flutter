import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/src/login/cubit/login_cubit.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/pages/login_email_screen.dart';
import 'package:podium/src/login/view/pages/login_password_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool emailIsValid = false;

  void returnToEmail() {
    debugPrint('returnToEmail is called in login_form.dart');
    setState(() {
      emailIsValid = false;
    });
    context.read<LoginCubit>().returnToEmail();
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
        } else if (state.emailIsValid == true) {
          debugPrint('state.emailIsValid == true');
          setState(() {
            emailIsValid = true;
          });
        }
      },
      child: emailIsValid == false
          ? const LoginEmailScreen()
          : LoginPasswordScreen(
              returnToEmail: returnToEmail,
            ),
    );
  }
}

// class _SignUpButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return TextButton(
//       key: const Key('loginForm_createAccount_flatButton'),
//       onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
//       child: Text(
//         'CREATE ACCOUNT',
//         style: TextStyle(color: theme.primaryColor),
//       ),
//     );
//   }
// }