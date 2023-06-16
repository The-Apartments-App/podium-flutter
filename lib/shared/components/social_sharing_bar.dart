import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaBar extends StatelessWidget {
  const SocialMediaBar({super.key});

  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue.shade900),
          onPressed: () => launchURL(
              'https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fpodiumapartments.com%2Fblogs%2F1'), // put your Facebook URL here
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
          onPressed: () => launchURL(
            'https://twitter.com/intent/tweet?text=Check%20out%20this%20new%20blog%20from%20Podium%20Apartments!%20https%3A%2F%2Fpodiumapartments.com%2Fblogs%2F1',
          ), // put your Twitter URL here
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.linkedin, color: Colors.blue.shade800),
          onPressed: () => launchURL(
            'https://www.linkedin.com/sharing/share-offsite/?url=https%3A%2F%2Fpodiumapartments.com%2Fblogs%2F1',
          ), // put your LinkedIn URL here
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.pinterest, color: Colors.pink),
          onPressed: () {
            final url =
                'https://www.pinterest.com/pin/create/button/?url=${Uri.encodeComponent('http://podiumapartments.com/blogs/1')}&media=${Uri.encodeComponent('https://www.structuremag.org/wp-content/uploads/2016/12/0117-ss-1.jpg')}&description=${Uri.encodeComponent("Check out Podium's newest blog!")}';
            launchURL(url);
          },
        ),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.link,
            size: 16,
          ), // You can replace with a chain icon if you have one
          onPressed: () {
            Clipboard.setData(
              const ClipboardData(text: 'https://podiumapartments.com/blogs/1'),
            );
            // Optionally, show a confirmation to the user
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Link copied to clipboard'),
              ),
            );
          },
        )
      ],
    );
  }
}
