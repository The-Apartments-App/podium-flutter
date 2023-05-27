// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:podium/bootstrap.dart';
import 'package:podium/src/app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  debugPrint('1. MAIN PRODUCTION IS RUNNING');
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  await Supabase.initialize(
    url: 'https://xyzcompany.supabase.co',
    anonKey: 'public-anon-key',
  );

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  await FacebookAuth.instance.webAndDesktopInitialize(
    appId: '1378794172984108',
    cookie: true,
    xfbml: true,
    version: 'v15.0',
  );

  runApp(App(authenticationRepository: authenticationRepository));
}
