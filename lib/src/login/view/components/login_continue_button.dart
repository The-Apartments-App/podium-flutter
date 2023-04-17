import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/components/login_phone_input.dart';
import 'package:podium/src/login/view/pages/login_phone_code_screen.dart';

class LoginContinueButton extends StatelessWidget {
  const LoginContinueButton({super.key, required this.isEmailInput});
  final bool isEmailInput;

  void onEmailContinue(BuildContext context) {
    context.read<LoginCubit>().checkEmailValidity();
  }

  void onPhoneContinue(BuildContext context) {
    context.read<LoginCubit>().checkPhoneValidity();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('isEmailInput in continue_button: $isEmailInput');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 48.5,
        child: ElevatedButton(
          onPressed: () => {
            if (isEmailInput)
              {context.read<LoginCubit>().checkEmailValidity()}
            else
              {context.read<LoginCubit>().checkPhoneValidity()}
          },
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
