import 'package:flutter/material.dart';
import 'package:podium/src/splash_page/splash_page_index.dart';

class SplashPageMainSection extends StatelessWidget {
  const SplashPageMainSection({
    super.key,
    required this.image,
    required this.title,
    required this.body,
  });

  final String image;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 650;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 64),
      child: Center(
        child: Wrap(
          spacing: 50,
          runAlignment: WrapAlignment.spaceBetween,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            splashSectionImage(
              image,
              context,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width < 1546 ? 40 : 0,
                    bottom: isMobile ? 40 : 80,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: isMobile ? 30 : 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    body,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
