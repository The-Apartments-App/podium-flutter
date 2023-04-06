import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/shared/shared_functions.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/login/cubit/login_cubit.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/login_continue_button.dart';
import 'package:podium/src/login/view/login_email_input.dart';
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
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .7,
        width: MediaQuery.of(context).size.width * .7,
        child: Scaffold(
          appBar: AppBar(
            leading: const CloseButton(),
            title: const Text('Log In or Sign Up'),
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(
                color: Colors.grey,
                height: 0.5,
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PodiumLogoWithTitle(height: 150, width: 150),
              const LoginEmailInput(),
              const SizedBox(height: 8),
              const LoginContinueButton(),
              // const LoginPasswordInput(),
              // const SizedBox(height: 8),
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      endIndent: 25,
                      thickness: 1.15,
                      color: Color(0xFFDDDDDD),
                    ),
                  ),
                  Text('or'),
                  Expanded(
                    child: Divider(
                      indent: 25,
                      thickness: 1.15,
                      color: Color(0xFFDDDDDD),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SignInButton(
                Buttons.google,
                onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
              ),
              SignInButton(
                Buttons.facebook,
                onPressed: () => context.read<LoginCubit>().logInWithFacebook(),
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
