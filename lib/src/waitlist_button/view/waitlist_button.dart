import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitlistButton extends StatefulWidget {
  const WaitlistButton({super.key});

  @override
  State<WaitlistButton> createState() => _WaitlistButtonState();
}

class _WaitlistButtonState extends State<WaitlistButton> {
  @override
  Widget build(BuildContext context) {
    Future<void> goToTypeForm() async {
      await launchUrl(
        Uri.parse('https://xhy4plsbs2i.typeform.com/to/k9E5sWoH'),
      );
    }

    return PlatformElevatedButton(
      onPressed: goToTypeForm,
      child: const Text(
        'Join the Waitlist',
        style: TextStyle(
          letterSpacing: .55,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
