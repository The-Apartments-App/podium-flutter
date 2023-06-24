import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallSupportButton extends StatelessWidget {
  const CallSupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> callSupport() async {
      await launchUrl(Uri.parse('tel:+16812619706'));
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 700,
          minHeight: 64,
        ),
        child: OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(width: 1.25),
            ), // Heavy border
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ), // Shape
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(10),
            ), // Inner padding
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: callSupport,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon // Spacing
              Text(
                'Call support',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ), // Text
            ],
          ),
        ),
      ),
    );
  }
}
