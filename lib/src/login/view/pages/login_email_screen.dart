import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:podium/src/login/login.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  bool isEmailInput = true;
  bool userIsABoss = false;
  Widget emailOrPhone() {
    if (isEmailInput == false) {
      return const LoginPhoneInput();
    } else {
      return const LoginEmailInput();
    }
  }

  void loginAuth(User user) {
    final ownerIds = ['kmbvxRaTSBfcf8Xk2CwstCpNQXp1'];
    userIsABoss = ownerIds.contains(user.id);
    if (userIsABoss) {
      context.push('/ownerHome');
    } else {
      context.push('/residentHome');
    }
  }

  @override
  Widget build(BuildContext context) {
    User user;
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
                    SocialSignInButton(
                      height: 20,
                      width: 20,
                      iconName: 'facebook-icon.svg',
                      buttonText: 'Continue with Facebook',
                      onPressed: () =>
                          context.read<LoginCubit>().logInWithFacebook().then(
                                (_) => context.push('/home'),
                              ),
                    ),
                    SocialSignInButton(
                      height: 18,
                      width: 18,
                      iconName: 'google-icon.svg',
                      buttonText: 'Continue with Google',
                      onPressed: () => context
                          .read<LoginCubit>()
                          .logInWithGoogle()
                          .then(
                            (_) => {
                              debugPrint('Successfully logged in with Google'),
                              user = context
                                  .read<AuthenticationRepository>()
                                  .currentUser,
                              debugPrint(
                                'this is user after login with google: $user',
                              ),
                              // context.push('/home'),
                              loginAuth(user),
                              debugPrint(
                                  'Successfully navigated to /ownerHome'),
                            },
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
                      onPressed: () async {
                        await showDialog<void>(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('Choose User Type'),
                              content: SizedBox(
                                height: 125,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PlatformElevatedButton(
                                      // style: PlatformElevatedButton.styleFrom(
                                      //   backgroundColor:
                                      //       const Color(0xff098d69),
                                      //   shape: RoundedRectangleBorder(
                                      //     borderRadius:
                                      //         BorderRadius.circular(10),
                                      //   ),
                                      //   padding: const EdgeInsets.symmetric(
                                      //     vertical: 20,
                                      //     horizontal: 30,
                                      //   ),
                                      // ),
                                      color: const Color(0xFF03795D),
                                      child: const Text('Resident Login'),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        try {
                                          await context
                                              .read<LoginCubit>()
                                              .logInWithDemoResidentUser()
                                              .then(
                                                (value) => {
                                                  debugPrint(
                                                    '''Successfully logged in with demo resident user''',
                                                  ),
                                                  if (mounted)
                                                    {
                                                      context.push(
                                                        '/residentHome',
                                                      ),
                                                      debugPrint(
                                                        'Successfully navigated to /residentHome',
                                                      ),
                                                    }
                                                },
                                              );
                                        } catch (e) {
                                          debugPrint(
                                            '''Error while logging in with demo resident user: $e''',
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    PlatformElevatedButton(
                                      // style: PlatformElevatedButton.styleFrom(
                                      //   backgroundColor:
                                      //       const Color(0xff098d69),
                                      //   shape: RoundedRectangleBorder(
                                      //     borderRadius:
                                      //         BorderRadius.circular(10),
                                      //   ),
                                      //   padding: const EdgeInsets.symmetric(
                                      //     vertical: 20,
                                      //     horizontal: 35,
                                      //   ),
                                      // ),
                                      color: const Color(0xFF03795D),
                                      child: const Text('Admin Login'),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        try {
                                          await context
                                              .read<LoginCubit>()
                                              .logInWithDemoAdminUser()
                                              .then(
                                                (value) => {
                                                  debugPrint(
                                                    '''Successfully logged in with demo admin user''',
                                                  ),
                                                  if (mounted)
                                                    {
                                                      context
                                                          .push('/ownerHome'),
                                                      debugPrint(
                                                        'Successfully navigated to /ownerHome',
                                                      ),
                                                    }
                                                },
                                              );
                                        } catch (e) {
                                          debugPrint(
                                            '''Error while logging in with demo admin user: $e''',
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
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
