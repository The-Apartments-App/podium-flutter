import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/home_page/view/home_page_banner.dart';
import 'package:podium/src/home_page/view/home_page_menu_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('3. HOME PAGE BUILT - User Account Page');
    }

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
                  ..._buildOwnerProfileMenu()
                else
                  ..._buildResidentProfileMenu(),
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

List<HomePageMenuItem> _buildResidentProfileMenu() {
  return [
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
  ];
}

List<HomePageMenuItem> _buildOwnerProfileMenu() {
  return [
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
}
