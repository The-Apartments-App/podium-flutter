import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/app/app.dart';

void routeToPage(
  BuildContext context,
  AppPage page,
) {
  context.flow<AppPage>().update((state) => page);
}

void routeToLogin(BuildContext context) {
  routeToPage(context, AppPage.userLogin);
}
