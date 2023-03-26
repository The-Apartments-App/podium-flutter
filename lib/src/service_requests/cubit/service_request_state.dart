part of 'service_request_cubit.dart';

enum ServiceType { emergency, nonemergency }

class ServiceRequestState extends Equatable {
  const ServiceRequestState({
    this.user = User.empty,
    this.serviceType = ServiceType.nonemergency,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final User user;
  final ServiceType serviceType;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [user, serviceType, status];

  ServiceRequestState copyWith({
    ServiceType? serviceType,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return ServiceRequestState(
      serviceType: serviceType ?? this.serviceType,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
