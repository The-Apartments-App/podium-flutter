import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:podium/src/login/login.dart';

class LoginContinueButton extends StatelessWidget {
  const LoginContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 48.5,
        child: PlatformElevatedButton(
          onPressed: () => {context.read<LoginCubit>().checkEmailValidity()},
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
