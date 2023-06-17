import 'package:flutter/material.dart';
import 'package:podium/src/website/website_pages_index.dart';

class SplashPageDesktopBanner extends StatefulWidget {
  const SplashPageDesktopBanner({super.key});

  @override
  State<SplashPageDesktopBanner> createState() =>
      _SplashPageDesktopBannerState();
}

class _SplashPageDesktopBannerState extends State<SplashPageDesktopBanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 160, right: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1500),
              child: Image.asset(
                'lib/src/assets/images/splash_page_top_image.jpg',
                fit: BoxFit.cover,
                height: 500,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        Positioned(
          top: 150,
          left: MediaQuery.of(context).size.width < 1100 ? 100 : 200,
          child: Container(
            height: 400,
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 5,
                  color: Colors.grey.withOpacity(0.3),
                  offset: const Offset(-2, 2),
                )
              ],
            ),
            child: const Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: SplashPageWelcomeWindow(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
