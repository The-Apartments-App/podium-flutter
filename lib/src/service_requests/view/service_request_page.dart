import 'package:authentication_repo/authentication_repo.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/appbar_back_button/appbar_back_button.dart';
import 'package:podium/src/service_requests/service_requests.dart';

class ServiceRequestPage extends StatelessWidget {
  const ServiceRequestPage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: ServiceRequestPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceRequestCubit>(
      create: (_) =>
          ServiceRequestCubit(context.read<AuthenticationRepository>()),
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const ServiceRequestForm(),
      ),
    );
  }
}
