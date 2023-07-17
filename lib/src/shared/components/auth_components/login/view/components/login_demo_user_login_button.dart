import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

class PodiumDemoUserLoginButton extends StatelessWidget {
  const PodiumDemoUserLoginButton({
    super.key,
    required this.buttonText,
    required this.route,
    required this.onPressed,
  });

  final String route;
  final String buttonText;
  final Future<void> onPressed;

  @override
  Widget build(BuildContext context) {
    void closeModalAndRoute(String route) {
      Navigator.pop(context);
      Navigator.pop(context);
      context.go(route);
    }

    return PlatformElevatedButton(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 35,
      ),
      color: const Color(0xFF03795D),
      child: Text(buttonText),
      onPressed: () async {
        await onPressed.then(
          (value) => closeModalAndRoute(route),
        );
      },
    );
  }
}
