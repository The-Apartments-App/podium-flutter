import 'package:flutter/material.dart';
import 'package:podium/src/shared/shared_index.dart';

Widget splashSectionImage(String fileName, BuildContext context) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: 900,
      minWidth: 400,
      minHeight: isMobile(context) ? 400 : 525,
      maxHeight: isMobile(context) ? 400 : 525,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'lib/src/assets/images/$fileName',
        fit: BoxFit.cover,
        width: isMobile(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * .85,
      ),
    ),
  );
}
