import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'service_request_state.dart';

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  ServiceRequestCubit() : super(const ServiceRequestState());
}
