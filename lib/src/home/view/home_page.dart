import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  @override
  void initState() {
    super.initState();
    debugPrint('3a. HOMEPAGE STATE INITIALIZED');
    final user = FirebaseAuth.instance.currentUser;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        debugPrint('3c. (if user == null) Routed to Login');
        routeToLogin(context);
      } else {
        debugPrint(
          'CURRENT USER: $user',
        );
        debugPrint(
          'CURRENT USER PROFILE PIC:${user.photoURL ?? "A user is logged in, but has no profilePic"}',
        );
      }
    });
  }

  void routeToLogin(BuildContext context) {
    context.flow<AppPage>().update((state) => AppPage.userLogin);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      '3b. HOME PAGE BUILT - User Account Page',
    );
    const userAccountPageTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 28,
    );

    final user = context.select((AppBloc bloc) => bloc.state.user);
    const defaultProfilePic = 'lib/src/assets/images/podium_logo.png';

    CircleAvatar getProfilePic() {
      if (user.photo != null) {
        // debugPrint('USER.PHOTO IS NOT NULL');
        // debugPrint('USER.PHOTO: ${user.photo}');
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          backgroundImage: NetworkImage(user.photo ?? 'https:www.google.com'),
        );
      } else {
        return const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          backgroundImage: AssetImage(defaultProfilePic),
        );
      }
    }

    String loginOrLogout() {
      if (user.isEmpty) {
        return 'Log In';
      } else {
        return 'Log Out';
      }
    }

    getProfilePic();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          Duration.zero,
          () => debugPrint('Page refreshed on pull down'),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 20, 4, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Text(
                      'Welcome, ${user.name ?? "Guest"}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    child: getProfilePic(),
                  )
                ],
              ),
            ),
            Divider(
              endIndent: MediaQuery.of(context).size.width * .6,
              thickness: 1.85,
              color: Colors.grey.shade400,
            ),
            TextButton(
              onPressed: () => {
                if (user.isEmpty)
                  {routeToLogin(context)}
                else
                  {
                    context
                        .flow<AppPage>()
                        .update((state) => AppPage.userPayments)
                  }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Payments',
                      style: userAccountPageTextStyle,
                    ),
                    Icon(
                      Icons.credit_card,
                      size: 36,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () => {
            //     if (user.isEmpty)
            //       {routeToLogin(context)}
            //     else
            //       {
            //         context
            //             .flow<AppPage>()
            //             .update((state) => AppPage.buildingAmenities)
            //       }
            //   },
            //   child: const Padding(
            //     padding: EdgeInsets.fromLTRB(64, 32, 64, 32),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           'Amenities',
            //           style: userAccountPageTextStyle,
            //         ),
            //         Icon(
            //           Icons.apartment,
            //           size: 36,
            //           color: Colors.black,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            TextButton(
              onPressed: () => {
                if (user.isEmpty)
                  {routeToLogin(context)}
                else
                  {
                    context
                        .flow<AppPage>()
                        .update((state) => AppPage.serviceRequest)
                  }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Service Request',
                      style: userAccountPageTextStyle,
                    ),
                    Icon(
                      Icons.home_repair_service,
                      size: 36,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                if (user.isEmpty)
                  {routeToLogin(context)}
                else
                  {
                    context
                        .flow<AppPage>()
                        .update((state) => AppPage.userDocuments)
                  }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Documents',
                      style: userAccountPageTextStyle,
                    ),
                    Icon(
                      Icons.file_copy,
                      size: 36,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                if (user.isEmpty)
                  {routeToLogin(context)}
                else
                  {
                    context
                        .flow<AppPage>()
                        .update((state) => AppPage.userSettings)
                  }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Settings',
                      style: userAccountPageTextStyle,
                    ),
                    Icon(
                      Icons.settings,
                      size: 36,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  {FirebaseAuth.instance.signOut(), routeToLogin(context)},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loginOrLogout(),
                      style: userAccountPageTextStyle,
                    ),
                    const Icon(
                      Icons.logout,
                      size: 36,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
