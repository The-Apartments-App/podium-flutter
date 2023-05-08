import 'package:flutter/material.dart';

void routeToPage(
  BuildContext context,
  String route,
) {
  Navigator.of(context).pushNamed('/$route');
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 700;
}
