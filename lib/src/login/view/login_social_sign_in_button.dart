import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        shadowColor: MaterialStatePropertyAll(Colors.transparent),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        side: MaterialStatePropertyAll(
          BorderSide(),
        ),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        foregroundColor: MaterialStatePropertyAll(Colors.black),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'lib/src/assets/images/facebook-icon.svg',
            height: 19,
            width: 19,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: () => onPressed,
    );
  }
}
