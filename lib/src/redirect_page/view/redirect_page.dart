import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RedirectPage extends StatelessWidget {
  const RedirectPage(this.redirectTo, {super.key});
  final String redirectTo;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.push(redirectTo);
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
