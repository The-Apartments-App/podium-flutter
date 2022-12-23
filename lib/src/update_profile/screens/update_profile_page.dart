
import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/update_profile/update_profile.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key, this.imageController});

  final Image? imageController;

  static Page<void> page() =>
      const MaterialPage<void>(child: UpdateProfilePage());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (_) =>
            UpdateProfileCubit(context.read<AuthenticationRepository>()),
        child: const UpdateProfileForm(),
      ),
    );
  }
}
