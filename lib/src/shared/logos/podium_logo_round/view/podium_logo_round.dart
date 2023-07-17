import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podium/src/shared/shared_index.dart';

class PodiumLogoRound extends StatelessWidget {
  const PodiumLogoRound({super.key, this.height, this.width});

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
        child: Image.asset(podiumLogoRound),
      ),
    );
  }
}
