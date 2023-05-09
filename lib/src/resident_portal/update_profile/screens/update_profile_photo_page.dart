import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/resident_portal/update_profile/update_profile.dart';

class UpdateProfilePhotoPage extends StatelessWidget {
  const UpdateProfilePhotoPage({super.key, this.imageController});

  final Image? imageController;

  static Page<void> page() =>
      const MaterialPage<void>(child: UpdateProfilePhotoPage());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (_) =>
            UpdateProfilePhotoCubit(context.read<AuthenticationRepository>()),
        child: const UpdateProfilePhotoForm (),
      ),
    );
  }
}
