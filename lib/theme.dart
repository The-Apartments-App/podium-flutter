import 'package:flutter/material.dart';

final ThemeData appTheme = buildAppTheme();

ThemeData buildAppTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: ZoomPageTransitionsBuilder(),
        TargetPlatform.linux: ZoomPageTransitionsBuilder(),
      },
    ),
    canvasColor: Colors.transparent,
    shadowColor: Colors.transparent,
    textTheme: _appTextTheme(base.textTheme),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(primary: const Color(0xFF03795D)),
    scaffoldBackgroundColor: const Color(0XFFFFFFFF),
  );
}

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith().apply(
        displayColor: Colors.black,
        bodyColor: Colors.black,
        fontFamily: 'Roboto',
      );
}
