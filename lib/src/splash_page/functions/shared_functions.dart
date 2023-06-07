import 'package:flutter/material.dart';

Widget splashSectionImage(String fileName, BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 650;
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: 900,
      minWidth: 400,
      minHeight: isMobile ? 400 : 525,
      maxHeight: isMobile ? 400 : 525,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'lib/src/assets/images/$fileName',
        fit: BoxFit.cover,
        width: isMobile
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * .85,
      ),
    ),
  );
}
