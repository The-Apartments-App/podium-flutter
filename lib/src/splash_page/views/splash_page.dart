import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:podium/shared/components/linked_in.dart';
import 'package:podium/src/podium_logo_with_title/podium_logo_with_title.dart';
import 'package:podium/src/splash_page/views/components/blog_feed.dart';
import 'package:podium/src/splash_page/views/components/faq.dart';
import 'package:podium/src/splash_page/views/components/feature_box.dart';
import 'package:podium/src/splash_page/views/components/resident_login_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 700;
    final desktopSplashImage = Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 160, right: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Image.asset(
                'lib/src/assets/images/blog_page_picture.jpg',
                fit: BoxFit.cover,
                height: 500,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        const Positioned(
          top: 70,
          left: 0,
          child: ResidentLoginContainer(),
        ),
      ],
    );

    final mobileSplashNoImage = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Elevate your lifestyle with Podium',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          """Find your perfect Podium pad, whether it's a cozy condo, chic city flat, or serene suburban retreat""",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 48.5,
            child: ElevatedButton(
              style: const ButtonStyle(
                shadowColor: MaterialStatePropertyAll(Colors.transparent),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              child: const Text(
                'Resident Login',
                style: TextStyle(
                  letterSpacing: .55,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () => {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 48.5,
            child: ElevatedButton(
              style: const ButtonStyle(
                shadowColor: MaterialStatePropertyAll(Colors.transparent),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              child: const Text(
                'Partnership Request',
                style: TextStyle(
                  letterSpacing: .55,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () => {},
            ),
          ),
        )
      ],
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
                //   child: Row(
                //     children: const [PodiumLogo(height: 40)],
                //   ),
                // ),
                // const Divider(),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1375),
                  child: Column(
                    children: [
                      //Splash Photo and User Action Box
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 36, 16, 56),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: isMobile
                              ? mobileSplashNoImage
                              : desktopSplashImage,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 64, 32, 64),
                        child: Center(
                          child: Wrap(
                            spacing: 180,
                            runAlignment: WrapAlignment.spaceBetween,
                            alignment: WrapAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 300,
                                  maxHeight: 300,
                                ),
                                child: const Placeholder(),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 40,
                                      bottom: 80,
                                    ),
                                    child: Text(
                                      'Welcome',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    child: const Text(
                                      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Suspendisse potenti nullam ac tortor vitae purus faucibus ornare suspendisse. Pellentesque pulvinar pellentesque habitant morbi tristique.''',
                                      style: TextStyle(
                                        fontSize: 16,
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
                        padding: const EdgeInsets.fromLTRB(32, 64, 32, 64),
                        child: Center(
                          child: Wrap(
                            spacing: 180,
                            verticalDirection:
                                MediaQuery.of(context).size.width < 1044
                                    ? VerticalDirection.up
                                    : VerticalDirection.down,
                            runAlignment: WrapAlignment.spaceBetween,
                            alignment: WrapAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 40,
                                      bottom: 80,
                                    ),
                                    child: Text(
                                      'Welcome',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    child: const Text(
                                      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Suspendisse potenti nullam ac tortor vitae purus faucibus ornare suspendisse. Pellentesque pulvinar pellentesque habitant morbi tristique.''',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 300,
                                  maxHeight: 300,
                                ),
                                child: const Placeholder(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 64, 32, 64),
                        child: Center(
                          child: Wrap(
                            spacing: 180,
                            runAlignment: WrapAlignment.spaceBetween,
                            alignment: WrapAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 300,
                                  maxHeight: 300,
                                ),
                                child: const Placeholder(),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 40,
                                      bottom: 80,
                                    ),
                                    child: Text(
                                      'Welcome',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    child: const Text(
                                      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Suspendisse potenti nullam ac tortor vitae purus faucibus ornare suspendisse. Pellentesque pulvinar pellentesque habitant morbi tristique.''',
                                      style: TextStyle(
                                        fontSize: 16,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 16, 64),
                        child: MediaQuery.of(context).size.width < 850
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FeatureBox(
                                    icon: Icon(Icons.apartment),
                                    headline: 'Property Management',
                                    details:
                                        '''Experience the future of property management with Podium. Let us take care of your investment while you sit back and watch it grow.''',
                                  ),
                                  FeatureBox(
                                    icon: Icon(FontAwesomeIcons.infinity),
                                    headline: 'Seamless Integration',
                                    details:
                                        '''With our expert team, global strategy, and local expertise, Podium offers seamless investment management services, unlocking the potential of your assets to yield maximum returns.''',
                                  ),
                                  FeatureBox(
                                    icon: Icon(Icons.abc),
                                    headline: 'Headline 3',
                                    details:
                                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nisl vel pretium lectus quam id. Euismod lacinia at quis risus sed vulputate.''',
                                  )
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FeatureBox(
                                    icon: Icon(Icons.apartment),
                                    headline: 'Property Management',
                                    details:
                                        '''Experience the future of property management with Podium. Let us take care of your investment while you sit back and watch it grow.''',
                                  ),
                                  FeatureBox(
                                    icon: Icon(FontAwesomeIcons.infinity),
                                    headline: 'Seamless Integration',
                                    details:
                                        '''With our expert team, global strategy, and local expertise, Podium offers seamless investment management services, unlocking the potential of your assets to yield maximum returns.''',
                                  ),
                                  FeatureBox(
                                    icon: Icon(Icons.abc),
                                    headline: 'Headline 3',
                                    details:
                                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nisl vel pretium lectus quam id. Euismod lacinia at quis risus sed vulputate.''',
                                  )
                                ],
                              ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 48, right: 32, bottom: 96),
                        child: BlogFeed(),
                      ),
                      // This will be the FAQ section,
                      // clickable with a short foldout answer
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(48, 0, 0, 32),
                                child: Text(
                                  'Common Questions, Clear Answers',
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 525),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 32),
                                child: Column(
                                  children: const [
                                    FAQ(
                                      question: 'How much coffee can I drink?',
                                      answer: 'A full gallon',
                                    ),
                                    FAQ(
                                      question:
                                          '''Is this the best apartment rental app on the market?''',
                                      answer: 'Yes, of course.',
                                    ),
                                    FAQ(
                                      question: 'Is Podium Tiktok famous?',
                                      answer: 'Podium is trending.',
                                    ),
                                    FAQ(
                                      question:
                                          '''Is this even a real question about anything?''',
                                      answer: 'No, but it could be.',
                                    ),
                                    FAQ(
                                      question:
                                          '''Want to learn more about Podium?''',
                                      answer:
                                          '''Contact us at info@podiumapartments.com''',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    PodiumLogoWithTitle(height: 80),
                    LinkedInLink(),
                    Text('© 2023 Podium Apartments Inc.')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
