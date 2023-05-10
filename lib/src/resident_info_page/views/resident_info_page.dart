import 'package:flutter/material.dart';
import 'package:podium/shared/shared.dart';
import 'package:podium/src/podium_logo_with_title/podium_logo_with_title.dart';
import 'package:podium/src/splash_page/views/components/feature_box.dart';
import 'package:podium/src/waitlist_button/view/waitlist_button.dart';

class ResidentInfoPage extends StatefulWidget {
  const ResidentInfoPage({super.key});

  @override
  State<ResidentInfoPage> createState() => _ResidentInfoPageState();
}

class _ResidentInfoPageState extends State<ResidentInfoPage> {
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 1348;

    const featureBoxes = [
      Padding(
        padding: EdgeInsets.only(top: 6, bottom: 6),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            Icon(Icons.home),
            Text(
              'Experience peace of mind in a secure and comfortable setting',
            ),
          ],
        ),
      ),

      Padding(
        padding: EdgeInsets.only(top: 6, bottom: 6),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            Icon(Icons.phone_android),
            Text(
              'Stay organized and in control with our user-friendly platform',
            ),
          ],
        ),
      ),

      // FeatureBox(
      //   icon: Icon(Icons.apartment),
      //   headline: 'Easy Management',
      //   details:
      //       '''Stay organized and in control with our user-friendly platform, simplifying your rental experience with a streamlined approach.''',
      // ),
      // SizedBox(height: 16),
      // FeatureBox(
      //   icon: Icon(Icons.phone_android),
      //   headline: 'Safety & Comfort',
      //   details:
      //       '''Experience peace of mind in a secure and comfortable setting, knowing that Podium prioritizes your well-being and satisfaction.''',
      // ),
    ];

    Widget splashSectionImage(String fileName) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'lib/src/assets/images/$fileName',
          fit: BoxFit.cover,
          height: 400,
          width: 700,
        ),
      );
    }

    final desktopAppBar = [
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 40, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const PodiumLogoWithTitle(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/residents');
                    },
                    child: const Text(
                      'Residents',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/services');
                    },
                    child: const Text(
                      'Services',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      const Divider()
    ];

    return Scaffold(
      appBar: isMobile(context)
          ? AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: const PodiumLogoWithTitle(
                height: kToolbarHeight,
              ),
              leadingWidth: 150,
              actions: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                )
              ],
              toolbarHeight: 150,
            )
          : null,
      drawer: isMobile(context)
          ? Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    child: PodiumLogoWithTitle(height: 150),
                  ),
                  ListTile(
                    title: const Text('Residents'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/residents');
                    },
                  ),
                  ListTile(
                    title: const Text('Services'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/services');
                    },
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                if (!isMobile(context)) ...desktopAppBar,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1450),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                        child: Center(
                          widthFactor: 2,
                          child: Wrap(
                            spacing: 160,
                            verticalDirection: isSmallScreen
                                ? VerticalDirection.up
                                : VerticalDirection.down,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: isSmallScreen ? 40 : 0,
                                      bottom: 64,
                                    ),
                                    child: const Text(
                                      'Welcome Home!',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 24, 8, 24),
                                    child: Text(
                                      'SERVICES OFFERED',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [...featureBoxes],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      8,
                                      48,
                                      8,
                                      48,
                                    ),
                                    child: SizedBox(
                                      height: 48.5,
                                      width: isMobile(context)
                                          ? MediaQuery.of(context).size.width
                                          : 390,
                                      child: const WaitlistButton(),
                                    ),
                                  )
                                ],
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 300,
                                  maxWidth: 760,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'lib/src/assets/images/splash_page_community.png',
                                    fit: BoxFit.cover,
                                    height: 700,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Wrap(
                            spacing: 50,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              splashSectionImage(
                                'splash_page_community.png',
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: isSmallScreen ? 40 : 0,
                                      bottom: 40,
                                    ),
                                    child: const Text(
                                      'Experience Seamless Living',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    child: const Text(
                                      '''Podium's intuitive platform connects you to your ideal apartment, ensuring a consistent, hassle-free living experience across all our properties.''',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Wrap(
                            spacing: 50,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            verticalDirection: isSmallScreen
                                ? VerticalDirection.up
                                : VerticalDirection.down,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: isSmallScreen ? 40 : 0,
                                      bottom: 40,
                                    ),
                                    child: const Text(
                                      'Delight in Thoughtful Amenities',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    child: const Text(
                                      '''Enjoy complimentary cold brew on tap, along with access to exclusive amenities designed to elevate your day-to-day living experience.''',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              splashSectionImage(
                                'splash_page_cold_brew.jpg',
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Wrap(
                            spacing: 50,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              splashSectionImage(
                                'splash_page_city_skyline.jpeg',
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: isSmallScreen ? 40 : 0,
                                      bottom: 40,
                                    ),
                                    child: const Text(
                                      'Join a Vibrant Community',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    child: const Text(
                                      '''Feel at home in a connected environment where residents can engage, share experiences, and create lasting friendships within our Podium properties.''',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      //These will be the feature boxes with icons and text
                    ],
                  ),
                ),
                const Divider(),
                if (MediaQuery.of(context).size.width > 320)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PodiumLogoWithTitle(height: 80),
                      LinkedInLink(),
                      Text('© 2023 Podium Apartments Inc.')
                    ],
                  )
                else
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PodiumLogoWithTitle(height: 80),
                      LinkedInLink(),
                      Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 36),
                        child: Text('© 2023 Podium Apartments Inc.'),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
