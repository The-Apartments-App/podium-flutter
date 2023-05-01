import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/components/login_continue_button.dart';
import 'package:podium/src/login/view/components/login_email_input.dart';
import 'package:podium/src/login/view/components/login_phone_input.dart';
import 'package:podium/src/login/view/components/login_social_sign_in_button.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  bool isEmailInput = true;
  Widget emailOrPhone() {
    if (isEmailInput == false) {
      return const LoginPhoneInput();
    } else {
      return const LoginEmailInput();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
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
                const SizedBox(height: 85),
                const LoginContinueButton(),
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
                        context.read<LoginCubit>().logInWithFacebook().then(
                              (value) =>
                                  Navigator.of(context).pushNamed('/home'),
                            ),
                      },
                    ),
                    SocialSignInButton(
                      height: 18,
                      width: 18,
                      iconName: 'google-icon.svg',
                      buttonText: 'Continue with Google',
                      onPressed: () =>
                          context.read<LoginCubit>().logInWithGoogle().then(
                                (value) =>
                                    Navigator.of(context).pushNamed('/home'),
                              ),
                    ),
                    SocialSignInButton(
                      height: 28,
                      width: 28,
                      iconName: 'apple-icon.svg',
                      buttonText: 'Continue with Apple',
                      onPressed: () =>
                          context.read<LoginCubit>().logInWithGoogle(),
                    ),
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
                    SocialSignInButton(
                      height: 28,
                      width: 28,
                      iconName: 'apple-icon.svg',
                      buttonText: 'Continue as Demo User',
                      onPressed: () async => {
                        await context
                            .read<LoginCubit>()
                            .logInWithDemoUser()
                            .then(
                              (value) => {
                                Navigator.of(context).pushNamed('/home'),
                              },
                            )
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
