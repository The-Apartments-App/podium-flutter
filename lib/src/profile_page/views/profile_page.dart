import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:podium/shared/shared_index.dart';
import 'package:podium/src/podium_desktop_app_bar/podium_desktop_app_bar_index.dart';
import 'package:podium/src/profile_page/views/components/profile_page_about_me.dart';
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
      appBar: isMobile(context) ? AppBar() : null,
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          Duration.zero,
          () => debugPrint('Page refreshed on pull down'),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (!isMobile(context)) const PodiumDesktopAppBar(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        verticalDirection:
                            MediaQuery.of(context).size.width < 978
                                ? VerticalDirection.up
                                : VerticalDirection.down,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(12, 24, 0, 24),
                                  child: Text(
                                    'My Profile',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
                      Divider(
                        endIndent: MediaQuery.of(context).size.width * .6,
                        thickness: .5,
                        color: Colors.grey.shade400,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1400),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 24, 0, 24),
                              child: Text(
                                'About Me',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ProfilePageAboutMe(
                              biographyTitle: '',
                              favoriteSong: '',
                              funFact: '',
                              language: '',
                              obsession: '',
                              residence: '',
                              school: '',
                              spendTime: '',
                              uselessSkill: '',
                              userBirthday: '',
                              userWork: '',
                            ),
                          ],
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
