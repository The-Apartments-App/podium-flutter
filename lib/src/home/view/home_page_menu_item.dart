import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/shared/shared_functions.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/home/view/home_page_icon.dart';

class HomePageMenuItem extends StatelessWidget {
  const HomePageMenuItem({
    super.key,
    required this.page,
    required this.buttonText,
    required this.icon,
    this.isLogOut,
  });

  final AppPage page;
  final String buttonText;
  final IconData icon;
  final bool? isLogOut;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    const homePageMenuItemTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 28,
    );

    void handleRoute(AppPage page) {
      if (isLogOut != null) {
        FirebaseAuth.instance.signOut();
      }
      if (user.isEmpty) {
        routeToLogin(context);
      } else {
        routeToPage(context, page);
      }
    }

    return TextButton(
      onPressed: () => {handleRoute(page)},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              style: homePageMenuItemTextStyle,
            ),
            HomePageIcon(icon: icon)
          ],
        ),
      ),
    );
  }
}
