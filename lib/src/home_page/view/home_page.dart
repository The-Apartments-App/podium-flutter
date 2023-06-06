import 'package:flutter/material.dart';
import 'package:podium/src/home_page/view/home_page_banner.dart';
import 'package:podium/src/home_page/view/home_page_menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
        route: 'home',
        buttonText: 'Dashboard',
        icon: Icons.info,
      ),
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              children: [
                const HomePageBanner(),
                Divider(
                  endIndent: MediaQuery.of(context).size.width * .6,
                  thickness: 1.85,
                  color: Colors.grey.shade400,
                ),
                if (false)
                  // ignore: dead_code
                  ...ownerProfileMenu
                else
                  ...residentProfileMenu,
                const HomePageMenuItem(
                  route: 'userSettings',
                  buttonText: 'Settings',
                  icon: Icons.settings,
                ),
                const HomePageMenuItem(
                  route: '',
                  buttonText: 'Log Out',
                  icon: Icons.logout,
                  isLogOut: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
