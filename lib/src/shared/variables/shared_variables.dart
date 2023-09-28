import 'package:flutter/material.dart';

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 700;
}

const podiumLogoRound = 'lib/src/shared/assets/images/podium_logo_round.png';
