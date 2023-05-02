import 'package:flutter/material.dart';
import 'package:podium/shared/shared_functions.dart';

class PodiumLogoWithTitle extends StatelessWidget {
  const PodiumLogoWithTitle({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routeToPage(context, '');
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          'lib/src/assets/images/podium_logo_with_title.png',
        ),
      ),
    );
  }
}
