import 'package:flutter/material.dart';
import 'package:podium/src/login/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final supabase = Supabase.instance.client;
    return ColoredBox(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: Stack(
              children: [
                const SizedBox(
                  height: 36,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
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
                const Column(
                  children: [
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
                    SignInButton(
                      iconHeight: 20,
                      iconWidth: 20,
                      iconName: 'facebook-icon.svg',
                      buttonText: 'Continue with Facebook',
                      onPressed: () async {
                        await supabase.auth
                            .signInWithOAuth(Provider.facebook)
                            .then(
                              (value) =>
                                  Navigator.of(context).pushNamed('/home'),
                            );
                      },
                    ),
                    SignInButton(
                      iconHeight: 18,
                      iconWidth: 18,
                      iconName: 'google-icon.svg',
                      buttonText: 'Continue with Google',
                      onPressed: () async {
                        try {
                          await supabase.auth.signInWithOAuth(
                            Provider.google,
                          );
                          debugPrint('this is context: $context');
                          // ignore: use_build_context_synchronously
                          await Navigator.pushNamed(context, '/home');
                        } catch (error) {
                          debugPrint(
                            'this is the sign in with Google Error: $error',
                          );
                        }
                      },
                    ),
                    SignInButton(
                      iconHeight: 28,
                      iconWidth: 28,
                      iconName: 'apple-icon.svg',
                      buttonText: 'Continue with Apple',
                      onPressed: () async {
                        await supabase.auth
                            .signInWithOAuth(Provider.apple)
                            .then(
                              (value) =>
                                  Navigator.of(context).pushNamed('/home'),
                            );
                      },
                    ),
                    SignInButton(
                      iconHeight: 19,
                      iconWidth: 19,
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
                    SignInButton(
                      iconHeight: 28,
                      iconWidth: 28,
                      iconName: 'apple-icon.svg',
                      buttonText: 'Continue as Demo User',
                      onPressed: () async => {
                        await supabase.auth
                            .signInWithPassword(
                              email: 'demouser@demo.com',
                              password: 'password',
                            )
                            .then(
                              (value) =>
                                  Navigator.of(context).pushNamed('/home'),
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
