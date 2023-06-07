import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/waitlist_button/waitlist_button.dart';

class SplashPageWelcomeWindow extends StatelessWidget {
  const SplashPageWelcomeWindow({super.key});

  @override
  Widget build(BuildContext context) {
    void displayModal(BuildContext context) {
      // Use MediaQuery to get the width of the screen
      final width = MediaQuery.of(context).size.width;

      if (width < 650) {
        // Display bottom sheet for small screen (e.g. mobile)
        showModalBottomSheet<void>(
          context: context,
          builder: (context) => ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: ListView(
                shrinkWrap: true,
                children: const [
                  LoginForm(),
                ],
              ),
            ),
          ),
        );
      } else {
        // Display dialog for large screen (e.g. desktop)
        showDialog<void>(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: Wrap(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: SizedBox(
                      width: 575,
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 400),
                        child: const LoginForm(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            'Experience Life with Podium',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            """Discover premium living spaces tailored for today's urban lifestyle.""",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 48.5,
            child: const WaitlistButton(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 48.5,
            child: PlatformElevatedButton(
              onPressed: false ? null : () => displayModal(context),
              child: const Text(
                'Login Coming Soon!',
                style: TextStyle(
                  letterSpacing: .55,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
