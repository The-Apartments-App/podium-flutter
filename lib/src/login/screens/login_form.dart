import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/login/cubit/login_cubit.dart';
import 'package:podium/src/login/login.dart';
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
          context.flow<AppPage>().update((state) => AppPage.userHome);
        }
      },
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/src/assets/images/podium_logo_with_title.png',
                height: 180,
              ),
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_LoginButton(), _DemoUserButton()],
              ),
              const SizedBox(height: 8),
              SignInButton(
                Buttons.google,
                onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
              ),
              SignInButton(
                Buttons.facebook,
                onPressed: () => context.read<LoginCubit>().logInWithFacebook(),
              ),
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

class _EmailInput extends StatefulWidget {
  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) {
              context.read<LoginCubit>().emailChanged(email);
              setState(() {
                showError = false;
              });
            },
            onEditingComplete: () {
              setState(() {
                showError = true;
              });
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'email',
              helperText: '',
              errorText:
                  state.email.isNotValid && showError ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<_PasswordInput> {
  @override
  void initState() {
    super.initState();
  }

  bool obscureTextSet = true;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) {
              context.read<LoginCubit>().passwordChanged(password);
              setState(() {
                showError = false;
              });
            },
            onEditingComplete: () {
              setState(() {
                showError = true;
              });
            },
            obscureText: obscureTextSet,
            decoration: InputDecoration(
              labelText: 'password',
              helperText: '',
              errorText: state.password.isNotValid && showError
                  ? 'invalid password'
                  : null,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureTextSet ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => {
                  setState(() {
                    obscureTextSet = !obscureTextSet;
                  })
                },
              ),
            ),
          ),
        );
      },
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
          context.flow<AppPage>().update((state) => AppPage.userHome),
        },
        child: const Text('Demo User'),
      ),
    );
  }
}
