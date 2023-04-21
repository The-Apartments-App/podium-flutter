import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/home/view/home_page_banner.dart';
import 'package:podium/src/home/view/home_page_menu_item.dart';
import 'package:podium/src/login/login.dart';

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
    debugPrint(
      '3. HOME PAGE BUILT - User Account Page',
    );
    screenSizeIsMobile = MediaQuery.of(context).size.width < 750;
    screenSizeIsDesktop = !screenSizeIsMobile!;

    final user = context.select((AppBloc bloc) => bloc.state.user);

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

    closeLogin(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          Duration.zero,
          () => debugPrint('Page refreshed on pull down'),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: ListView(
            children: [
              const HomePageBanner(),
              Divider(
                indent: 25,
                endIndent: 25,
                thickness: 1.85,
                color: Colors.grey.shade400,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 40, 0, 40),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
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
              // const HomePageMenuItem(
              //   route: 'buildingAmenities',
              //   buttonText: 'Amenities',
              //   icon: Icons.apartment,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
