import 'package:flutter/material.dart';


void routeToPage(
  BuildContext context,
  String route,
) {
  Navigator.of(context).pushNamed('/$route');
}
