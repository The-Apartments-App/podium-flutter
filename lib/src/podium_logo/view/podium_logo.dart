import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/app/app.dart';

class PodiumLogo extends StatelessWidget {
  const PodiumLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.flow<AppPage>().update((state) => AppPage.userHome);
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
