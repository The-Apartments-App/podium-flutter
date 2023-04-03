import 'package:flutter/material.dart';
import 'package:podium/src/listings/listings_page.dart';
import 'package:podium/src/login/login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: SplashPage());

  @override
  Widget build(BuildContext context) {
    const mobileScreen = [LoginPage()];
    const desktopScreen = [LoginPage(), ListingsPage()];

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: MediaQuery.of(context).size.width < 768
            ? mobileScreen
            : desktopScreen,
      ),
    );
  }
}
