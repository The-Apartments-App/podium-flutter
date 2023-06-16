import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:podium/src/app/app.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  Future<void> onButtonTapped(BuildContext context) async {
    if (context.mounted) {
      context.read<AppBloc>().add(AppLogoutRequested());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformElevatedButton(
      onPressed: () => onButtonTapped(context),
      child: const Text('Log Out'),
    );
  }
}
