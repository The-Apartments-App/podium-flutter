import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/shared/shared_index.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  bool isEmailInput = true;
  Widget emailOrPhone() {
    return isEmailInput ? const LoginEmailInput() : const LoginPhoneInput();
  }

  void loginAuth(User user) {
    debugPrint('user in loginAuth');
    var userIsABoss = false;
    final ownerIds = ['kmbvxRaTSBfcf8Xk2CwstCpNQXp1'];
    userIsABoss = ownerIds.contains(user.id);
    userIsABoss ? context.go('/ownerHome') : context.go('/residentProfile');
  }

  //PLEASE REFACTOR ME
  void closeModalAndRoute(String route) {
    Navigator.pop(context);
    Navigator.pop(context);
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    // User user;
    final appBloc = context.select((AppBloc bloc) => bloc);
    final signedInUser = appBloc.state.user;
    debugPrint('signInUser: $signedInUser');
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
                                (_) => context.go('/home'),
                              ),
                    ),
                    SocialSignInButton(
                      height: 18,
                      width: 18,
                      iconName: 'google-icon.svg',
                      buttonText: 'Continue with Google',
                      onPressed: () =>
                          context.read<LoginCubit>().logInWithGoogle().then(
                                (_) => {
                                  loginAuth(signedInUser),
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
                              title: const Text('Choose Login'),
                              content: SizedBox(
                                height: 275,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PodiumDemoUserLoginButton(
                                      buttonText: 'Resident Demo Login',
                                      route: '/residentProfile',
                                      onPressed: context
                                          .read<LoginCubit>()
                                          .logInWithDemoUser('resident'),
                                    ),
                                    const SizedBox(height: 16),
                                    PodiumDemoUserLoginButton(
                                      buttonText: 'Building Owner Demo Login',
                                      route: '/ownerHome',
                                      onPressed: context
                                          .read<LoginCubit>()
                                          .logInWithDemoUser('buildingOwner'),
                                    ),
                                    const SizedBox(height: 16),
                                    PodiumDemoUserLoginButton(
                                      buttonText:
                                          'Community Manager Demo Login',
                                      route: '/communityManager',
                                      onPressed: context
                                          .read<LoginCubit>()
                                          .logInWithDemoUser(
                                            'communityManager',
                                          ),
                                    ),
                                    const SizedBox(height: 16),
                                    PodiumDemoUserLoginButton(
                                      buttonText: 'Maintenance Tech Demo Login',
                                      route: '/maintenanceTech',
                                      onPressed: context
                                          .read<LoginCubit>()
                                          .logInWithDemoUser(
                                            'maintenanceTech',
                                          ),
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
