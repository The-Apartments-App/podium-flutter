import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/app_bar_back_button/app_bar_back_button.dart';
import 'package:podium/src/resident_portal/service_requests/service_requests.dart';

class ServiceRequestPage extends StatelessWidget {
  const ServiceRequestPage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: ServiceRequestPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceRequestCubit>(
      create: (_) => ServiceRequestCubit(),
      child: Scaffold(
        appBar: !kIsWeb
            ? AppBar(
                leading: const AppBarBackButton(route: '/residentHome'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              )
            : null,
        body: const ServiceRequestForm(),
      ),
    );
  }
}
