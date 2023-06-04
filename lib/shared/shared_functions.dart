import 'package:flutter/material.dart';

void routeToPage(
  BuildContext context,
  String route,
) {
  Navigator.of(context).pushNamed('/$route');
}

Widget getProfilePic() {
  const defaultProfilePic = 'lib/src/assets/images/podium_logo_square.png';
  // if (user.photo != null) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: Image.network(
  //       user.photo!,
  //     ),
  //   );
  // } else {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.asset(
      height: 48,
      width: 48,
      defaultProfilePic,
    ),
  );
  // }
}
