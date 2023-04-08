import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.iconName,
    required this.height,
    required this.width,
  });
  final String buttonText;
  final String iconName;
  final Function onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.675,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
          child: Row(
            children: [
              SvgPicture.asset(
                'lib/src/assets/images/$iconName',
                height: height,
                width: width,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width < 740
                      ? MediaQuery.of(context).size.width * .75
                      : 430,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        buttonText,
                        style: const TextStyle(
                          letterSpacing: .55,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
