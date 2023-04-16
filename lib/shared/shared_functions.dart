import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/podium_logo/podium_logo.dart';

Page<void> toPage(Widget page, String name) {
  return MaterialPage<void>(
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF03795D),
        shadowColor: Colors.transparent,
        leading: const PodiumLogo(),
      ),
      body: page,
    ),
    name: name,
  );
}

void routeToPage(
  BuildContext context,
  AppPage page,
) {
  context.flow<AppPage>().update((state) => page);
}
