import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/shared/shared_functions.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/login/cubit/login_cubit.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/login_continue_button.dart';
import 'package:podium/src/login/view/login_email_input.dart';
import 'package:podium/src/login/view/login_phone_input.dart';
import 'package:podium/src/login/view/login_social_sign_in_button.dart';
import 'package:podium/src/signup/sign_up.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isEmailInput = true;
  @override
  Widget build(BuildContext context) {
    debugPrint('isEmailInput: $isEmailInput');

    Widget emailOrPhone() {
      if (isEmailInput == false) {
        return const LoginPhoneInput();
      } else {
        return const LoginEmailInput();
      }
    }

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
          routeToPage(context, AppPage.userHome);
        }
      },
      child: ColoredBox(
        color: const Color(0xFFFFFFFF),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
              child: Stack(
                children: [
                  SizedBox(
                    height: 36,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: const [
                        Expanded(
                          child: Text(
                            'Log in or sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Transform.scale(
                      scale: .85,
                      child: const CloseButton(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                children: [
                  Column(
                    children: const [
                      SizedBox(height: 2),
                      Text(
                        'Welcome to Podium',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                  emailOrPhone(),
                  Transform.translate(
                    offset: const Offset(0, -5),
                    child: const LoginContinueButton(),
                  ),
                  Row(
                    children: [
                      const SizedBox(height: 56),
                      Expanded(
                        child: Divider(
                          endIndent: 25,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const Text(
                        'or',
                        style: TextStyle(fontSize: 11.5),
                      ),
                      Expanded(
                        child: Divider(
                          indent: 25,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    runSpacing: 15.5675,
                    children: [
                      SocialSignInButton(
                        height: 20,
                        width: 20,
                        iconName: 'facebook-icon.svg',
                        buttonText: 'Continue with Facebook',
                        onPressed: () => {
                          context.read<LoginCubit>().logInWithFacebook(),
                        },
                      ),
                      // const SizedBox(height: 16),
                      SocialSignInButton(
                        height: 18,
                        width: 18,
                        iconName: 'google-icon.svg',
                        buttonText: 'Continue with Google',
                        onPressed: () =>
                            context.read<LoginCubit>().logInWithGoogle(),
                      ),
                      // const SizedBox(height: 16),
                      SocialSignInButton(
                        height: 28,
                        width: 28,
                        iconName: 'apple-icon.svg',
                        buttonText: 'Continue with Apple',
                        onPressed: () =>
                            context.read<LoginCubit>().logInWithGoogle(),
                      ),
                      // const SizedBox(height: 16),
                      SocialSignInButton(
                        height: 19,
                        width: 19,
                        iconName: isEmailInput != true
                            ? 'email-icon.svg'
                            : 'phone-icon.svg',
                        buttonText: isEmailInput != true
                            ? 'Continue with Email'
                            : 'Continue with Phone',
                        onPressed: () => setState(
                          () => {
                            if (isEmailInput != true)
                              isEmailInput = true
                            else
                              isEmailInput = false
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: state.status.isInProgress
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color(0xFF1A966E),
                  ),
                  onPressed: () =>
                      context.read<LoginCubit>().logInWithCredentials(),
                  child: const Text('Login'),
                ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}

class _DemoUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: const Color(0xFF1A966E),
        ),
        onPressed: () => {
          context.read<LoginCubit>().logInWithDemoUser(),
          routeToPage(context, AppPage.userHome),
        },
        child: const Text('Demo User'),
      ),
    );
  }
}
