import 'package:flutter/material.dart';
import 'package:podium/src/partnerships_button/partnerships_button.dart';
import 'package:podium/src/podium_logo_with_title/podium_logo_with_title.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: const PodiumLogoWithTitle(),
            ),
            const Text(
              'Coming Soon...',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 40,
                color: Color(0xff098d69),
              ),
            ),
            const SizedBox(height: 45, width: 180, child: PartnershipsButton())
          ],
        ),
      ),
    );
  }
}
