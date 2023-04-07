import 'package:flutter/material.dart';

class LoginContinueButton extends StatelessWidget {
  const LoginContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -4.3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .92,
          height: 48.5,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Continue',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
