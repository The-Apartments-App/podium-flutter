import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/website/website_pages_index.dart';

class SplashPageCarousel extends StatefulWidget {
  const SplashPageCarousel({super.key});

  @override
  State<SplashPageCarousel> createState() => _SplashPageCarouselState();
}

class _SplashPageCarouselState extends State<SplashPageCarousel> {
  @override
  Widget build(BuildContext context) {
    final carouselController = CarouselController();

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 900,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            initialPage: 2,
            autoPlayCurve: Curves.easeIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            viewportFraction: 1,
            autoPlay: true,
          ),
          items: [
            splashSectionImage(
              'orange_theory_podium.jpg',
              context,
            ),
            splashSectionImage(
              'chase_bank_podium.jpg',
              context,
            ),
            splashSectionImage(
              'trader_joes_podium.jpg',
              context,
            ),
            splashSectionImage(
              'sola_salons_podium.jpg',
              context,
            ),
            splashSectionImage(
              'whole_foods_podium.jpg',
              context,
            ),
          ],
        ),
      ),
    );
  }
}
