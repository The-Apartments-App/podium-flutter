import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/shared/shared_functions.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/login/cubit/login_cubit.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/login_email_screen.dart';
import 'package:podium/src/login/view/login_password_screen.dart';
import 'package:podium/src/signup/sign_up.dart';

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
          Navigator.of(context).pop();
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

// class _LoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.all(2),
//           child: state.status.isInProgress
//               ? const CircularProgressIndicator()
//               : ElevatedButton(
//                   key: const Key('loginForm_continue_raisedButton'),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     backgroundColor: const Color(0xFF03795D),
//                   ),
//                   onPressed: () =>
//                       context.read<LoginCubit>().logInWithCredentials(),
//                   child: const Text('Login'),
//                 ),
//         );
//       },
//     );
//   }
// }

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

// class _DemoUserButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           backgroundColor: const Color(0xFF03795D),
//         ),
//         onPressed: () => {
//           context.read<LoginCubit>().logInWithDemoUser(),
//           routeToPage(context, AppPage.userHome),
//         },
//         child: const Text('Demo User'),
//       ),
//     );
//   }
// }
