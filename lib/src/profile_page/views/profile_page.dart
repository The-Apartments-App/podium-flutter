import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/app_bar_back_button/view/app_bar_back_button.dart';
import 'package:podium/src/profile_page/views/components/profile_page_about_me.dart';
import 'package:podium/src/profile_page/views/components/profile_page_card.dart';
import 'package:podium/src/profile_page/views/components/profile_page_menu_item.dart';
import 'package:podium/src/shared/shared_index.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.select((AppBloc bloc) => bloc);
    void signOut() {
      appBloc.add(AppLogoutRequested());
      context.go('/');
    }

    PreferredSizeWidget? buildAppBar(BuildContext context) {
      return isMobile(context)
          ? AppBar(
              backgroundColor: Colors.white,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Divider(),
              ),
              title: const AppBarBackButton(route: '/'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                    onPressed: () {
                      // handle hamburger menu button press here
                    },
                    tooltip: 'Show options',
                    // ignore: use_named_constants
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    // Create a builder to build the popup menu
                    icon: PopupMenuButton<String>(
                      icon: const Icon(Icons.menu),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Home',
                          child: Text('Home'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Logout',
                          child: Text('Logout'),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'Home') {
                          context.go('/residentProfile');
                          // Handle navigation to home
                        } else if (value == 'Logout') {
                          // Handle logout
                          signOut();
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
          : AppBar(
              backgroundColor: Colors.white,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Divider(),
              ),
              title: const Padding(
                padding: EdgeInsets.only(top: 32),
                child: PodiumLogoWithTitle(height: 125),
              ),
              actions: [
                Container(
                  alignment: Alignment.center,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: .5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            // handle hamburger menu button press here
                          },
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'Home') {
                              context.go('/residentProfile');
                              // Handle navigation to home
                            } else if (value == 'Logout') {
                              // Handle logout
                              signOut();
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Home',
                              child: Text('Home'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Logout',
                              child: Text('Logout'),
                            ),
                          ],
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              backgroundImage: AssetImage(
                                'lib/src/assets/images/podium_logo_round.png',
                              ), // Your user's profile picture here
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
    }

    if (kDebugMode) {
      print('3. PROFILE PAGE BUILT - User Account Page');
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          Duration.zero,
          () => debugPrint('Page refreshed on pull down'),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(width: 2),
                    ), // Heavy border
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ), // Shape
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(10),
                    ), // Inner padding
                    backgroundColor:
                        MaterialStateProperty.all(Colors.white), // Button color
                  ),
                  onPressed: signOut,
                  child: const Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black), // Icon
                      SizedBox(width: 8), // Spacing
                      Text(
                        'Log Out',
                        style: TextStyle(color: Colors.black),
                      ), // Text
                    ],
                  ),
                ),
              )
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
