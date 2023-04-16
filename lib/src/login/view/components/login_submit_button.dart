import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podium/src/login/login.dart';

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 48.5,
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(2),
            child: ElevatedButton(
              key: const Key('loginForm_continue_raisedButton'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFF03795D),
              ),
              onPressed: () =>
                  context.read<LoginCubit>().logInWithCredentials(),
              child: state.status.isInProgress
                  ? DotsIndicator(
                      dotsCount: 3,
                      decorator: const DotsDecorator(
                        color: Color(0xFFFFFFFF),
                        activeColor: Colors.grey,
                      ),
                    )
                  : const Text('Log in'),
            ),
          );
        },
      ),
    );
  }
}
