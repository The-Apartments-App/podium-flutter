import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedInLink extends StatelessWidget {
  const LinkedInLink({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        const url = 'https://www.linkedin.com/company/podium-apartments/';
        await launchUrl(Uri.parse(url));
      },
      icon: const FaIcon(FontAwesomeIcons.linkedin),
    );
  }
}
