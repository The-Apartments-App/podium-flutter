import 'package:flutter/material.dart';
import 'package:podium/shared/shared_functions.dart';
import 'package:podium/src/app/app.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: () => routeToPage(context, AppPage.userHome),
    );
  }
}
