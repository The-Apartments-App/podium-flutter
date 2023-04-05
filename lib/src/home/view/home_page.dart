import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/home/view/home_page_banner.dart';
import 'package:podium/src/home/view/home_page_menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  @override
  Widget build(BuildContext context) {
    debugPrint(
      '3. HOME PAGE BUILT - User Account Page',
    );

    final user = context.select((AppBloc bloc) => bloc.state.user);

    String loginOrLogout() {
      if (user.isEmpty) {
        return 'Log In';
      } else {
        return 'Log Out';
      }
    }

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
            const HomePageMenuItem(
              page: AppPage.userPayments,
              buttonText: 'Payments',
              icon: Icons.credit_card,
            ),
            const HomePageMenuItem(
              page: AppPage.serviceRequest,
              buttonText: 'Service Request',
              icon: Icons.home_repair_service,
            ),
            const HomePageMenuItem(
              page: AppPage.userDocuments,
              buttonText: 'Documents',
              icon: Icons.file_copy,
            ),
            const HomePageMenuItem(
              page: AppPage.userSettings,
              buttonText: 'Settings',
              icon: Icons.settings,
            ),
            HomePageMenuItem(
              page: AppPage.userLogin,
              buttonText: loginOrLogout(),
              icon: Icons.logout,
              isLogOut: true,
            ),
            // const HomePageMenuItem(
            //   page: AppPage.buildingAmenities,
            //   buttonText: 'Amenities',
            //   icon: Icons.apartment,
            // ),
          ],
        ),
      ),
    );
  }
}
