import 'package:authentication_repo/authentication_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/shared/shared_functions.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/home/view/home_page_icon.dart';
import 'package:podium/src/login/login.dart';

class HomePageMenuItem extends StatelessWidget {
  const HomePageMenuItem({
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
    final user = context.select((AppBloc bloc) => bloc.state.user);

    const homePageMenuItemTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    void showLogin(BuildContext context) {
      MediaQuery.of(context).size.width >= 750
          ? showDialog<void>(
              context: context,
              builder: (_) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    child: BlocProvider(
                      create: (_) =>
                          LoginCubit(context.read<AuthenticationRepository>()),
                      child: Wrap(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: SizedBox(
                              width: 575,
                              child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: 400),
                                child: const LoginForm(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).whenComplete(
              () => Navigator.of(context).pop(),
            )
          : showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: BlocProvider(
                    create: (_) =>
                        LoginCubit(context.read<AuthenticationRepository>()),
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        LoginForm(),
                      ],
                    ),
                  ),
                );
              },
            ).whenComplete(
              () => Navigator.of(context).pop(),
            );
    }

    void handleRoute(String route) {
      if (isLogOut != null) {
        FirebaseAuth.instance.signOut();
      }
      if (user.isEmpty) {
        showLogin(context);
      } else {
        routeToPage(context, route);
      }
    }

    return Column(
      children: [
        TextButton(
          onPressed: () => {handleRoute(route)},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 12, 6),
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
