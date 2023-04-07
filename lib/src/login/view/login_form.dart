import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/shared/shared_functions.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/login/cubit/login_cubit.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/login_continue_button.dart';
import 'package:podium/src/login/view/login_email_input.dart';
import 'package:podium/src/login/view/login_social_sign_in_button.dart';
import 'package:podium/src/podium_logo_with_title/view/podium_logo_with_title.dart';
import 'package:podium/src/signup/sign_up.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  Widget _showAppleSignInButton() {
    // if (Platform.isIOS) {
    //   return SignInButton(
    //     Buttons.Apple,
    //     onPressed: () {
    //       // _signInWithApple();
    //     },
    //   );
    // } else {
    // }
    return const SizedBox(height: 8);
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
          routeToPage(context, AppPage.userHome);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          leading: const CloseButton(),
          title: const Text(
            'Log in or sign up',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(.2),
            child: Container(
              color: Colors.grey.shade700,
              height: .1,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 11),
              Row(
                children: const [
                  Text(
                    'Welcome to Podium',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(height: 21),
              const LoginEmailInput(),
              const LoginContinueButton(),
              // const LoginPasswordInput(),
              const SizedBox(height: 20.5),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 25,
                      thickness: 0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const Text(
                    'or',
                    style: TextStyle(fontSize: 11.5),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 25,
                      thickness: 0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: SocialSignInButton(
                  buttonText: 'Continue with Facebook',
                  onPressed: () =>
                      context.read<LoginCubit>().logInWithFacebook(),
                ),
              ),
              SignInButton(
                Buttons.google,
                onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_LoginButton(), _DemoUserButton()],
              ),
              const SizedBox(height: 8),
              // _showAppleSignInButton(),
              const SizedBox(height: 4),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

//
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
