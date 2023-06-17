import 'package:flutter/material.dart';
import 'package:podium/src/shared/shared_index.dart';

class PodiumAppBar extends StatelessWidget {
  const PodiumAppBar({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return buildAppBar(context);
  }
}

PreferredSizeWidget buildAppBar(BuildContext context) {
  return isMobile(context)
      ? AppBar(
          backgroundColor: Colors.white,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Divider(),
          ),
          title: const BackButton(),
          actions: [
            IconButton(
              onPressed: () {
                // handle hamburger menu button press here
              },
              tooltip: 'Show options',
              // ignore: use_named_constants
              padding: const EdgeInsets.all(0),
              constraints: const BoxConstraints(),
              // Create a builder to build the popup menu
              icon: PopupMenuButton<String>(
                icon: const Icon(Icons.menu),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Home',
                    child: Text('Home'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text('Logout'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'Home') {
                    // Handle navigation to home
                  } else if (value == 'Logout') {
                    // Handle logout
                  }
                },
              ),
            ),
          ],
        )
      : AppBar(
          backgroundColor: Colors.white,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Divider(),
          ),
          title: const PodiumLogoRound(height: kToolbarHeight),
          actions: [
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: .5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      // handle hamburger menu button press here
                    },
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String result) {
                      if (result == 'Home') {
                        // Handle navigation to home
                      } else if (result == 'Logout') {
                        // Handle logout
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Home',
                        child: Text('Home'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Logout',
                        child: Text('Logout'),
                      ),
                    ],
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          'lib/src/assets/images/podium_logo_round.png',
                        ), // Your user's profile picture here
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
}
