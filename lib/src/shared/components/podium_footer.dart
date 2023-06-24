import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podium/src/shared/shared_index.dart';

class PodiumFooter extends StatelessWidget {
  const PodiumFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Divider(
            thickness: 0,
            color: Colors.grey.shade200,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 901),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PodiumLogoWithTitle(height: 80),
              Row(
                children: [
                  SocialMediaLink(
                    socialUrl:
                        'https://www.linkedin.com/company/podium-apartments/',
                    socialIcon: FontAwesomeIcons.linkedin,
                  ),
                  SocialMediaLink(
                    socialUrl:
                        'https://www.linkedin.com/company/podium-apartments/',
                    socialIcon: FontAwesomeIcons.facebook,
                  ),
                  SocialMediaLink(
                    socialUrl:
                        'https://www.linkedin.com/company/podium-apartments/',
                    socialIcon: FontAwesomeIcons.twitter,
                  ),
                ],
              ),
              Text('© 2023 Podium Apartments Inc.')
            ],
          ),
        ),
      ],
    );
  }
}
