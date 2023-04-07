import 'package:flutter/material.dart';
import 'package:podium/src/coming_soon/coming_soon.dart';
import 'package:podium/src/listings/listings_page.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/login/view/login_mobile_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: SplashPage());

  @override
  Widget build(BuildContext context) {
    final mobileScreen = [LoginMobilePage(parentContext: context)];
    const desktopScreen = [LoginDesktopModal(), ListingsPage()];
    const comingSoon = [ComingSoon()];
    return Stack(
      // children: comingSoon,
      children: MediaQuery.of(context).size.width <= 600
          ? mobileScreen
          : desktopScreen,
    );
  }
}
