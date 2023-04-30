import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/resident_portal/user_home/view/home_page_banner.dart';
import 'package:podium/src/resident_portal/user_home/view/home_page_menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  bool? screenSizeIsMobile;
  bool? screenSizeIsDesktop;
  bool loginIsShowing = true;
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
    );
    setState(() {
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
        debugPrint('loginIsShowing: $loginIsShowing');
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenSizeIsMobile = MediaQuery.of(context).size.width < 750;
      if ((screenSizeIsMobile ?? false) && !isLoggedIn) {
        showMobileLogin(context);
      } else if ((screenSizeIsDesktop ?? false) && !isLoggedIn) {
        showDesktopLogin(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSizeIsMobile =
        WidgetsBinding.instance.window.physicalSize.width < 750;
    screenSizeIsDesktop = !screenSizeIsMobile!;
    closeLogin(context);
    debugPrint(
      '3. HOME PAGE BUILT - User Account Page',
    );

    final user = context.select((AppBloc bloc) => bloc.state.user);
    if (user.isEmpty) {
      debugPrint('user.isEmpty: ${user.isEmpty}');
      setState(() {
        isLoggedIn = false;
      });
      debugPrint('isLoggedIn: $isLoggedIn');
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }

    if (user.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }

    String loginOrLogout() {
      if (user.isEmpty) {
        return 'Log In';
      } else {
        return 'Log Out';
      }
    }

    final residentProfileMenu = [
      const HomePageMenuItem(
        route: 'userPayments',
        buttonText: 'Payments',
        icon: Icons.credit_card,
      ),
      const HomePageMenuItem(
        route: 'serviceRequest',
        buttonText: 'Service Request',
        icon: Icons.home_repair_service,
      ),
      const HomePageMenuItem(
        route: 'userDocuments',
        buttonText: 'Documents',
        icon: Icons.file_copy,
      ),
      // const HomePageMenuItem(
      //   route: 'buildingAmenities',
      //   buttonText: 'Amenities',
      //   icon: Icons.apartment,
      // )
    ];

    final ownerProfileMenu = [
      const HomePageMenuItem(
        route: 'ownerLedgers',
        buttonText: 'Ledgers',
        icon: Icons.balance,
      ),
      const HomePageMenuItem(
        route: 'ownerBuildingInfo',
        buttonText: 'Property Info',
        icon: Icons.home_repair_service,
      ),
      const HomePageMenuItem(
        route: 'ownerBuildingInspections',
        buttonText: 'Inspection Info',
        icon: Icons.file_copy,
      ),
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          Duration.zero,
          () => debugPrint('Page refreshed on pull down'),
        ),
        child: ListView(
          children: [
            const HomePageBanner(),
            Divider(
              endIndent: MediaQuery.of(context).size.width * .6,
              thickness: 1.85,
              color: Colors.grey.shade400,
            ),
            ...residentProfileMenu,
            const HomePageMenuItem(
              route: 'userSettings',
              buttonText: 'Settings',
              icon: Icons.settings,
            ),
            HomePageMenuItem(
              route: 'userHome',
              buttonText: loginOrLogout(),
              icon: Icons.logout,
              isLogOut: true,
            ),
          ],
        ),
      ),
    );
  }
}
