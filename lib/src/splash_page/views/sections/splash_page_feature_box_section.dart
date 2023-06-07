import 'package:flutter/material.dart';
import 'package:podium/src/splash_page/views/components/splash_page_feature_box.dart';

class SplashPageFeatureBoxSection extends StatelessWidget {
  const SplashPageFeatureBoxSection({super.key});

  @override
  Widget build(BuildContext context) {
    const featureBoxes = [
      FeatureBox(
        icon: Icons.apartment,
        headline: 'Redefining the Rental Experience',
        details:
            '''Discover a new era of apartment living with Podium's cutting-edge platform, intuitively designed to bring tenants and property owners together. Our technology-driven approach is reshaping the rental landscape, fostering innovation and setting new standards for the industry.''',
      ),
      SizedBox(height: 32, width: 32),
      FeatureBox(
        icon: Icons.phone_android,
        headline: 'Consistency at Your Fingertips',
        details:
            '''Enjoy the comfort and reliability of a consistent living experience in every Podium-managed property. Our user-friendly platform connects you to your ideal apartment, ensuring hassle-free living with a high standard of quality.''',
      ),
      SizedBox(height: 32, width: 32),
      FeatureBox(
        icon: Icons.trending_up_sharp,
        headline: 'Empowering Property Owners',
        details:
            '''Unlock the full potential of your property with powerful tools and real-time data that simplify management and boost returns. Our platform is designed to streamline operations and optimize performance for the modern building owner.''',
      )
    ];
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1375),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(64, 40, 64, 64),
        child: MediaQuery.of(context).size.width < 850
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [...featureBoxes],
                ),
              )
            : const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [...featureBoxes],
              ),
      ),
    );
  }
}
