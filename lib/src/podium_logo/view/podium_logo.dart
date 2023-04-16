import 'package:flutter/material.dart';
import 'package:podium/shared/shared_functions.dart';
import 'package:podium/src/app/app.dart';

class PodiumLogo extends StatelessWidget {
  const PodiumLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routeToPage(context, AppPage.userHome);
      },
      child: SizedBox(
        height: kToolbarHeight,
        child: Image.asset(
          'lib/src/assets/images/podium_logo.png',
        ),
      ),
    );
  }
}