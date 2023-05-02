import 'package:flutter/material.dart';
import 'package:podium/src/appbar_back_button/appbar_back_button.dart';
import 'package:podium/src/resident_portal/update_profile/update_profile.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 40, 0, 40),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 16,
                    child: const UpdateProfilePhotoPage(),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Update Photo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Divider(
            indent: 25,
            endIndent: 25,
            thickness: 0,
            color: Colors.grey.shade400,
          ),
          TextButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 16,
                    child: const UpdateProfileDisplayNamePage(),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Update Display Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Divider(
            indent: 25,
            endIndent: 25,
            thickness: 0,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
