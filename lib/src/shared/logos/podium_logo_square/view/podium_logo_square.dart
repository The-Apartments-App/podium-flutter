import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PodiumLogoSquare extends StatelessWidget {
  const PodiumLogoSquare({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/');
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          'lib/src/shared/assets/images/podium_logo_square.png',
        ),
      ),
    );
  }
}
