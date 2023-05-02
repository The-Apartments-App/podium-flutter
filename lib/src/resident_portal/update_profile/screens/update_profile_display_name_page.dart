import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/resident_portal/update_profile/update_profile.dart';

class UpdateProfileDisplayNamePage extends StatelessWidget {
  const UpdateProfileDisplayNamePage({ super.key, this.displayName });

  final String? displayName;

  static Page<void> page() => const MaterialPage<void>(child: UpdateProfileDisplayNamePage());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
        child: BlocProvider(
        create: (_) =>
            UpdateProfileCubit(context.read<AuthenticationRepository>()),
        child: const UpdateProfilePhotoForm (),
        ),
    );
  }

}