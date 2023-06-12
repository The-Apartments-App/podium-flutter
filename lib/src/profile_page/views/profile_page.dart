import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/profile_page/views/components/profile_page_card.dart';
import 'package:podium/src/profile_page/views/components/profile_page_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('3. PROFILE PAGE BUILT - User Account Page');
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          Duration.zero,
          () => debugPrint('Page refreshed on pull down'),
        ),
        child: Wrap(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  const ProfilePageMenuItem(
                    route: 'userSettings',
                    buttonText: 'Settings',
                    icon: Icons.settings,
                  ),
                  const ProfilePageMenuItem(
                    route: '',
                    buttonText: 'Log Out',
                    icon: Icons.logout,
                    isLogOut: true,
                  ),
                ],
              ),
            ),
            const ProfilePageCard(),
          ],
        ),
      ),
    );
  }
}

List<ProfilePageMenuItem> _buildResidentProfileMenu() {
  return [
    const ProfilePageMenuItem(
      route: 'userPayments',
      buttonText: 'Payments',
      icon: Icons.credit_card,
    ),
    const ProfilePageMenuItem(
      route: 'serviceRequest',
      buttonText: 'Service Request',
      icon: Icons.home_repair_service,
    ),
    const ProfilePageMenuItem(
      route: 'userDocuments',
      buttonText: 'Documents',
      icon: Icons.file_copy,
    ),
  ];
}

List<ProfilePageMenuItem> _buildOwnerProfileMenu() {
  return [
    const ProfilePageMenuItem(
      route: 'home',
      buttonText: 'Dashboard',
      icon: Icons.info,
    ),
    const ProfilePageMenuItem(
      route: 'ownerLedgers',
      buttonText: 'Ledgers',
      icon: Icons.balance,
    ),
    const ProfilePageMenuItem(
      route: 'ownerBuildingInfo',
      buttonText: 'Property Info',
      icon: Icons.home_repair_service,
    ),
    const ProfilePageMenuItem(
      route: 'ownerBuildingInspections',
      buttonText: 'Inspection Info',
      icon: Icons.file_copy,
    ),
  ];
}
