import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/shared/shared.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/podium_logo_with_title/podium_logo_with_title.dart';
import 'package:podium/src/splash_page/views/components/blog_feed.dart';
import 'package:podium/src/splash_page/views/components/faq.dart';
import 'package:podium/src/splash_page/views/components/feature_box.dart';
import 'package:podium/src/waitlist_button/waitlist_button.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool? screenSizeIsMobile;
  bool? screenSizeIsDesktop;
  bool loginIsShowing = false;
  bool desktopIsShowing = false;
  bool mobileIsShowing = false;
  bool hasBeenVisited = false;
  bool isLoggedIn = false;

  void showDesktopLogin(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: Wrap(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: SizedBox(
                      width: 575,
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 400),
                        child: const LoginForm(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() => loginIsShowing = false);
    setState(() {
      loginIsShowing = true;
      desktopIsShowing = true;
    });
  }

  void showMobileLogin(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BlocProvider(
            create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
            child: ListView(
              shrinkWrap: true,
              children: const [
                LoginForm(),
              ],
            ),
          ),
        );
      },
    );
    setState(() {
      loginIsShowing = true;
      mobileIsShowing = true;
    });
  }

  void closeLogin(BuildContext context) {
    if (desktopIsShowing && (screenSizeIsMobile!)) {
      Navigator.of(context).pop();
      setState(() {
        desktopIsShowing = false;
      });
      if (loginIsShowing) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showMobileLogin(context);
        });
      }
    } else if (mobileIsShowing && (screenSizeIsDesktop!)) {
      Navigator.of(context).pop();
      setState(() {
        mobileIsShowing = false;
      });
      if (loginIsShowing) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDesktopLogin(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSizeIsMobile = isMobile(context);
    screenSizeIsDesktop = !isMobile(context);

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
                'lib/src/assets/images/splash_page_top_image.jpg',
                fit: BoxFit.cover,
                height: 500,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 5,
                  color: Colors.grey.withOpacity(0.3),
                  offset: const Offset(-2, 2),
                )
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Experience Life with Podium',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            """Discover premium living spaces tailored for today's urban lifestyle.""",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
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
                                shadowColor: MaterialStatePropertyAll(
                                  Colors.transparent,
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Continue to Login',
                                style: TextStyle(
                                  letterSpacing: .55,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: () => {showDesktopLogin(context)},
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 48.5,
                            child: const WaitlistButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    final mobileSplashNoImage = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Experience Life with Podium',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Text(
                  """Discover premium living spaces tailored for today's urban lifestyle""",
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
                        shadowColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Continue to Login',
                        style: TextStyle(
                          letterSpacing: .55,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () => {showMobileLogin(context)},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 48.5,
                    child: const WaitlistButton(),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );

    const featureBoxes = [
      FeatureBox(
        icon: Icon(Icons.apartment),
        headline: 'Redefining the Rental Experience',
        details:
            '''Discover a new era of apartment living with Podium's cutting-edge platform, intuitively designed to bring tenants and property owners together. Our technology-driven approach is reshaping the rental landscape, fostering innovation and setting new standards for the industry.''',
      ),
      SizedBox(height: 16),
      FeatureBox(
        icon: Icon(Icons.phone_android),
        headline: 'Consistency at Your Fingertips',
        details:
            '''Enjoy the comfort and reliability of a consistent living experience in every Podium-managed property. Our user-friendly platform connects you to your ideal apartment, ensuring hassle-free living with a high standard of quality.''',
      ),
      SizedBox(height: 16),
      FeatureBox(
        icon: Icon(Icons.trending_up_sharp),
        headline: 'Empowering Property Owners',
        details:
            '''Unlock the full potential of your property with powerful tools and real-time data that simplify management and boost returns. Our platform is designed to streamline operations and optimize performance for the modern building owner.''',
      )
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
                      debugPrint('Residents appbar clicked');
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

    closeLogin(context);

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
                  constraints: const BoxConstraints(maxWidth: 1375),
                  child: Column(
                    children: [
                      //Splash Photo and User Action Box
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 36, 16, 32),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: isMobile(context)
                              ? mobileSplashNoImage
                              : desktopSplashImage,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Wrap(
                            spacing: 50,
                            runAlignment: WrapAlignment.spaceBetween,
                            alignment: WrapAlignment.center,
                            children: [
                              splashSectionImage(
                                'splash_page_community.png',
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 40,
                                      bottom: 40,
                                    ),
                                    child: Text(
                                      'A Lively Atmosphere',
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
                                      '''Podium buildings create an inviting environment where residents can connect, share experiences, and feel a sense of belonging. Our properties offer a unique ambiance that adds to the overall living experience, fostering a vibrant community.''',
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
                            runAlignment: WrapAlignment.spaceBetween,
                            alignment: WrapAlignment.center,
                            verticalDirection:
                                MediaQuery.of(context).size.width < 1400
                                    ? VerticalDirection.up
                                    : VerticalDirection.down,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 40,
                                      bottom: 40,
                                    ),
                                    child: Text(
                                      'Elevate Your Everyday',
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
                                      '''Indulge in the small luxuries that make a big difference in your daily routine. Our attention to detail and thoughtfully curated amenities, like complimentary cold brew, create an unparalleled living experience that goes beyond the ordinary. Experience the Podium difference and savor the moments that truly matter.''',
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
                            runAlignment: WrapAlignment.spaceBetween,
                            alignment: WrapAlignment.center,
                            children: [
                              splashSectionImage(
                                'splash_page_city_skyline.jpeg',
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 40,
                                      bottom: 40,
                                    ),
                                    child: Text(
                                      'Expanding Horizons',
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
                                      '''Join a growing network of distinctive properties that redefine urban living. With our expanding portfolio of Podium buildings, you'll be part of a thriving community that enjoys a consistent, quality experience across a diverse range of locations. Embrace the future of residential living and discover the true potential of a connected lifestyle.''',
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 16, 64),
                        child: isMobile(context)
                            ? const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [...featureBoxes],
                              )
                            : const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [...featureBoxes],
                              ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 32, right: 32),
                        child: BlogFeed(),
                      ),
                      // This will be the FAQ section,
                      // clickable with a short foldout answer
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: 40,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 0, 16, 32),
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(minWidth: 125),
                                child: const Text(
                                  'Common Questions, Clear Answers',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  left: 32,
                                  right: 32,
                                ),
                                child: Column(
                                  children: [
                                    FAQ(
                                      question:
                                          '''What makes Podium different from other apartment rental platforms?''',
                                      answer:
                                          '''Podium offers a comprehensive platform that integrates every aspect of property management, unlike traditional management companies that rely on third-party payment and listing services.''',
                                    ),
                                    FAQ(
                                      question:
                                          '''How does Podium ensure a consistent and high-quality living experience for its residents?''',
                                      answer:
                                          '''Distinguishing itself from other digital rental platforms, Podium directly manages the buildings, ensuring on-site managers are available to provide support and assistance.''',
                                    ),
                                    FAQ(
                                      question:
                                          '''Can I list my property on Podium? What are the requirements for property owners to join the platform?''',
                                      answer:
                                          '''Our platform is currently not open to general property submissions as we focus on partnering with premium-level properties. If you're interested in discussing a potential partnership, please contact us at info@podiumapartments.com for more information.''',
                                    ),
                                    FAQ(
                                      question:
                                          '''How does Podium's platform help property owners manage their apartments more effectively?''',
                                      answer:
                                          '''Utilizing cutting-edge technology, Podium delivers an advanced and efficient property management experience for both tenants and property owners.''',
                                    ),
                                    FAQ(
                                      question:
                                          '''Are there any additional benefits or amenities for residents living in Podium-managed properties?''',
                                      answer:
                                          '''At Podium, our managed properties feature exclusive amenities such as complimentary cold brew and thoughtfully designed community spaces, guaranteeing a consistently high-quality living experience that fosters comfort and engagement for our residents.''',
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
