import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/podium_logo/podium_logo.dart';

Page<void> toPage(Widget page, String name) => MaterialPage<void>(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          foregroundColor: const Color(0xFF1A966E),
          shadowColor: Colors.transparent,
          leading: const PodiumLogo(),
        ),
        body: page,
      ),
      name: name,
    );

void routeToScreen(
  BuildContext context,
  AppPage page,
  String route,
  User? user,
) {
  Navigator.pushNamed(context, route);
}

void routeToLogin(BuildContext context) {
  routeToScreen(context, AppPage.userLogin, '/login', User.empty);
}
