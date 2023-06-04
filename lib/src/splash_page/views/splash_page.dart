// ignore_for_file: dead_code

import 'package:authentication_repo/authentication_repo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/shared/components/linkedin_link.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/podium_logo_with_title/podium_logo_with_title.dart';
// import 'package:podium/src/splash_page/views/components/blog_feed.dart';
import 'package:podium/src/splash_page/views/components/faq.dart';
import 'package:podium/src/splash_page/views/components/feature_box.dart';
import 'package:podium/src/waitlist_button/waitlist_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @override
  void initState() {
    super.initState();

    /// Load auth session.
    ///
    /// Wait a minium `delayed` time in any case
    /// to avoid flashing screen.
    Future.wait([
      SupabaseAuth.instance.initialSession,
      Future<void>.delayed(
        const Duration(milliseconds: 2000),
      ),
    ]).then((responseList) {
      final session = responseList.first as Session?;
      debugPrint('this is session: $session');
    });
  }

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
    final isMobile = MediaQuery.of(context).size.width < 650;
    screenSizeIsMobile = isMobile;
    screenSizeIsDesktop = !isMobile;
    final carouselController = CarouselController();
    const weAreLive = true;

    final desktopSplashImage = Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 160, right: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1500),
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
          top: 150,
          left: MediaQuery.of(context).size.width < 1100 ? 100 : 200,
          child: Container(
            height: 400,
            width: 500,
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
                            child: const WaitlistButton(),
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
                              onPressed: !weAreLive
                                  ? null
                                  : () => {showDesktopLogin(context)},
                              child: const Text(
                                'Login Coming Soon!',
                                style: TextStyle(
                                  letterSpacing: .55,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
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
            padding: const EdgeInsets.fromLTRB(36, 36, 16, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Experience Life with Podium',
                    style: TextStyle(
                      fontSize: isMobile ? 30 : 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  """Discover premium living spaces tailored for today's urban lifestyle""",
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
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
                      onPressed:
                          !weAreLive ? null : () => {showMobileLogin(context)},
                      child: const Text(
                        'Continue to Login',
                        style: TextStyle(
                          letterSpacing: .55,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
        icon: Icons.apartment,
        headline: 'Redefining the Rental Experience',
        details:
            '''Discover a new era of apartment living with Podium's cutting-edge platform, intuitively designed to bring tenants and property owners together. Our technology-driven approach is reshaping the rental landscape, fostering innovation and setting new standards for the industry.''',
      ),
      SizedBox(height: 32, width: 32),
      FeatureBox(
        icon: Icons.phone_android,
        headline: 'Consistency at Your Fingertips',
        details:
            '''Enjoy the comfort and reliability of a consistent living experience in every Podium-managed property. Our user-friendly platform connects you to your ideal apartment, ensuring hassle-free living with a high standard of quality.''',
      ),
      SizedBox(height: 32, width: 32),
      FeatureBox(
        icon: Icons.trending_up_sharp,
        headline: 'Empowering Property Owners',
        details:
            '''Unlock the full potential of your property with powerful tools and real-time data that simplify management and boost returns. Our platform is designed to streamline operations and optimize performance for the modern building owner.''',
      )
    ];

    Widget splashSectionImage(String fileName) {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 900,
          minWidth: 400,
          maxHeight: 750,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'lib/src/assets/images/$fileName',
            fit: BoxFit.cover,
            width: isMobile
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * .85,
          ),
        ),
      );
    }

    closeLogin(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Row(
                  children: [PodiumLogoWithTitle(height: 125)],
                ),
              ),
              // const Divider(),
              Column(
                children: [
                  //Splash Photo and User Action Box
                  Padding(
                    padding:
                        EdgeInsets.only(right: 16, bottom: isMobile ? 90 : 180),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child:
                          isMobile ? mobileSplashNoImage : desktopSplashImage,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(isMobile ? 16 : 48),
                    child: Center(
                      child: Wrap(
                        spacing: 50,
                        runAlignment: WrapAlignment.spaceBetween,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          splashSectionImage(
                            'splash_page_community.jpg',
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width < 1546
                                      ? 40
                                      : 0,
                                  bottom: isMobile ? 40 : 80,
                                ),
                                child: Text(
                                  'A Lively Atmosphere',
                                  style: TextStyle(
                                    fontSize: isMobile ? 30 : 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: Text(
                                  '''Podium buildings create an inviting environment where residents can connect, share experiences, and feel a sense of belonging. Our properties offer a unique ambiance that adds to the overall living experience, fostering a vibrant community.''',
                                  style: TextStyle(
                                    fontSize: isMobile ? 18 : 22,
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
                    padding: isMobile
                        ? const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 48,
                            bottom: 48,
                          )
                        : const EdgeInsets.all(48),
                    child: Center(
                      child: Wrap(
                        spacing: 50,
                        runAlignment: WrapAlignment.spaceBetween,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        verticalDirection:
                            MediaQuery.of(context).size.width < 1800
                                ? VerticalDirection.up
                                : VerticalDirection.down,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width < 1546
                                      ? 40
                                      : 0,
                                  bottom: isMobile ? 40 : 80,
                                ),
                                child: Text(
                                  'Urban Lifestyle at Your Doorstep',
                                  style: TextStyle(
                                    fontSize: isMobile ? 30 : 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: Text(
                                  '''Explore the conveniences of modern living in our Podium buildings. Our prime locations feature an array of premium retail partners, bringing the best of city living right to your front door.''',
                                  style: TextStyle(
                                    fontSize: isMobile ? 18 : 22,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // splashSectionImage(
                          //   'podium.jpg',
                          // ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 900,
                            ),
                            child: CarouselSlider(
                              carouselController: carouselController,
                              options: CarouselOptions(
                                initialPage: 2,
                                autoPlayCurve: Curves.easeIn,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 900),
                                viewportFraction: 1,
                                autoPlay: true,
                              ),
                              items: [
                                splashSectionImage(
                                  'orange_theory_podium.jpg',
                                ),
                                splashSectionImage(
                                  'chase_bank_podium.jpg',
                                ),
                                splashSectionImage(
                                  'trader_joes_podium.jpg',
                                ),
                                splashSectionImage(
                                  'sola_salons_podium.jpg',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(isMobile ? 16 : 48),
                    child: Center(
                      child: Wrap(
                        spacing: 50,
                        runAlignment: WrapAlignment.spaceBetween,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          splashSectionImage(
                            'splash_page_city_skyline.jpg',
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width < 1546
                                      ? 40
                                      : 0,
                                  bottom: isMobile ? 40 : 80,
                                ),
                                child: Text(
                                  'Expanding Horizons',
                                  style: TextStyle(
                                    fontSize: isMobile ? 30 : 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: Text(
                                  '''Join a growing network of distinctive properties that redefine urban living. With our expanding portfolio of Podium buildings, you'll be part of a thriving community that enjoys a consistent, quality experience across a diverse range of locations. Embrace the future of residential living and discover the true potential of a connected lifestyle.''',
                                  style: TextStyle(
                                    fontSize: isMobile ? 18 : 22,
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
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1375),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(64, 40, 64, 64),
                      child: MediaQuery.of(context).size.width < 850
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [...featureBoxes],
                              ),
                            )
                          : const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [...featureBoxes],
                            ),
                    ),
                  ),
                  // const Padding(
                  //   padding:
                  //       EdgeInsets.only(left: 48, right: 32, bottom: 96),
                  //   child: BlogFeed(),
                  // ),
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
                          padding: const EdgeInsets.fromLTRB(48, 0, 16, 32),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 125),
                            child: Text(
                              'Common Questions, Clear Answers',
                              style: TextStyle(
                                fontSize: isMobile ? 30 : 36,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 400,
                            maxWidth: 500,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: isMobile ? 0 : 32),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Column(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PodiumLogoWithTitle(height: 80),
                  LinkedInLink(),
                  Text('© 2023 Podium Apartments Inc.')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
