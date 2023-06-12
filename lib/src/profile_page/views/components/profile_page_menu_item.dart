import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/profile_page/views/components/profile_page_icon.dart';

class ProfilePageMenuItem extends StatelessWidget {
  const ProfilePageMenuItem({
    super.key,
    required this.route,
    required this.buttonText,
    required this.icon,
    this.isLogOut,
  });

  final String route;
  final String buttonText;
  final IconData icon;
  final bool? isLogOut;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.select((AppBloc bloc) => bloc);
    final user = appBloc.state.user;

    const profilePageMenuItemTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    void signOut() {
      appBloc.add(AppLogoutRequested());
      context.go('/');
    }

    void handleRoute(String route) {
      if (isLogOut ?? false) {
        debugPrint('User Signed Out');
        signOut();
      }
      if (user.isEmpty) {
        debugPrint('user is empty, routing home.');
        context.go('/');
      } else {
        context.go('/$route');
      }
    }

    return Column(
      children: [
        TextButton(
          onPressed: () => handleRoute(route),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 12, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonText,
                  style: profilePageMenuItemTextStyle,
                ),
                ProfilePageIcon(icon: icon)
              ],
            ),
          ),
        ),
        Divider(
          indent: 25,
          endIndent: 25,
          thickness: 0,
          color: Colors.grey.shade400,
        )
      ],
    );
  }
}
