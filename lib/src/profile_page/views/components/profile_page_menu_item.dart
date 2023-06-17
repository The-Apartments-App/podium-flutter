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
  });

  final String route;
  final String buttonText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.select((AppBloc bloc) => bloc);

    final user = appBloc.state.user;

    const profilePageMenuItemTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontSize: 16,
    );

    void handleRoute(String route) {
      if (user.isEmpty) {
        debugPrint('user is empty, routing home.');
        context.go('/');
      } else {
        context.go('/$route');
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: TextButton(
        onPressed: () => handleRoute(route),
        child: Row(
          children: [
            ProfilePageIcon(icon: icon),
            Text(
              buttonText,
              style: profilePageMenuItemTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
