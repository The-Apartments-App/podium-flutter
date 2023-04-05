import 'package:flutter/material.dart';
import 'package:podium/src/partnerships_button/partnerships_button.dart';
import 'package:podium/src/podium_logo_with_title/podium_logo_with_title.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: const PodiumLogoWithTitle(),
        ),
        Text(
          'Coming Soon..',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 40,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [Color(0x00ff0069), Color(0xFF098D69)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
        const SizedBox(height: 45, width: 180, child: PartnershipsButton())
      ],
    );
  }
}
