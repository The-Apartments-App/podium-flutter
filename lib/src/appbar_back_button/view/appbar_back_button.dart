import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/app/app.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: () => {
        context.flow<AppPage>().update((state) => AppPage.userHome),
      },
    );
  }
}
