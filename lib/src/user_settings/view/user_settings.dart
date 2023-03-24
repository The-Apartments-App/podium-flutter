import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/app/app.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => {
            context.flow<AppPage>().update((state) => AppPage.userHome),
          },
        ),
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
            child: const Padding(
              padding: EdgeInsets.fromLTRB(64, 32, 64, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
