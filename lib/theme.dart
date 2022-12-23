import 'package:flutter/material.dart';

final ThemeData appTheme = buildAppTheme();

ThemeData buildAppTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    textTheme: _appTextTheme(base.textTheme),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(primary: const Color(0xFF1A966E)),
  );
}

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith().apply(
        displayColor: Colors.black,
        bodyColor: Colors.black,
        fontFamily: 'Questrial',
      );
}
