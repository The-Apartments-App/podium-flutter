import 'package:flutter/material.dart';
import 'package:podium/src/appbar_back_button/appbar_back_button.dart';
import 'package:podium/src/update_profile/update_profile.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: UserSettingsPage());

  @override
  Widget build(BuildContext context) {
    debugPrint('USER SETTINGS SCREEN LOADED');
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Divider(
            endIndent: MediaQuery.of(context).size.width * .6,
            thickness: 1.85,
            color: Colors.grey.shade400,
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 16,
                    child: const UpdateProfilePage(),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Update Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.account_circle,
                    size: 36,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
