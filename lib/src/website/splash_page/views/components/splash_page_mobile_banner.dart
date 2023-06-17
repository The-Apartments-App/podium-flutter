import 'package:flutter/material.dart';
import 'package:podium/src/website/website_pages_index.dart';

class SplashPageMobileBanner extends StatefulWidget {
  const SplashPageMobileBanner({super.key});

  @override
  State<SplashPageMobileBanner> createState() => _SplashPageMobileBannerState();
}

class _SplashPageMobileBannerState extends State<SplashPageMobileBanner> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(36, 36, 16, 0),
            child: SplashPageWelcomeWindow(),
          ),
        )
      ],
    );
  }
}
