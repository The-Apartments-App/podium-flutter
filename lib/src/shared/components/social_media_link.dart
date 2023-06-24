import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLink extends StatelessWidget {
  const SocialMediaLink({
    super.key,
    required this.socialUrl,
    required this.socialIcon,
  });

  final String socialUrl;
  final IconData socialIcon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        const url = 'https://www.linkedin.com/company/podium-apartments/';
        await launchUrl(Uri.parse(url));
      },
      icon: FaIcon(socialIcon),
    );
  }
}
