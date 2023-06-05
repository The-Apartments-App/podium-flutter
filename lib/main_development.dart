// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:authentication_repo/authentication_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/bootstrap.dart';
import 'package:podium/firebase_options.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  debugPrint('MAIN DEVELOPMENT IS RUNNING');
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  await Supabase.initialize(
    url: 'https://dwulrobndxgnknmlcaoi.supabase.co',
    anonKey: Env.supabaseKey,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthenticationRepository();
  // await authenticationRepository.user.first;

  runApp(App(authenticationRepository: authenticationRepository));
}
