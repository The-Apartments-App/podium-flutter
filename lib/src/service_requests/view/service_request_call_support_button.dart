import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallSupportButton extends StatelessWidget {
  const CallSupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> callSupport() async {
      if (!await launchUrl(Uri.parse('tel:+16812619706'))) {
        throw Exception('Could not call Darren.');
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 20),
      child: SizedBox(
        height: 48.675,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: const ButtonStyle(
            shadowColor: MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
            side: MaterialStatePropertyAll(
              BorderSide(
                color: Colors.grey,
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black),
          ),
          onPressed: callSupport,
          child: Row(
            children: [
              const Icon(Icons.phone),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: const [
                    Text(
                      'Call Support',
                      style: TextStyle(
                        letterSpacing: .55,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
