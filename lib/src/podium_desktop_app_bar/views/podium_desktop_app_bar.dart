import 'package:flutter/material.dart';
import 'package:podium/src/podium_logo_with_title/podium_logo_with_title.dart';

class PodiumDesktopAppBar extends StatelessWidget {
  const PodiumDesktopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 128),
          child: Row(
            children: [PodiumLogoWithTitle(height: 100)],
          ),
        ),
        Divider()
      ],
    );
  }
}
