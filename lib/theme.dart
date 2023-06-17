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
    textTheme: _appTextTheme(base.textTheme),
    appBarTheme: _appBarTheme(base.appBarTheme),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(primary: const Color(0xFF03795D)),
    scaffoldBackgroundColor: Colors.white,
  );
}

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith().apply(
        displayColor: Colors.black,
        bodyColor: Colors.black,
        fontFamily: 'Roboto',
      );
}

AppBarTheme _appBarTheme(AppBarTheme base) {
  return base.copyWith(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
    iconTheme: const IconThemeData(color: Colors.black),
  );
}
