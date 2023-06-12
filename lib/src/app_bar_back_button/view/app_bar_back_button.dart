import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: () => context.go(route),
    );
  }
}
