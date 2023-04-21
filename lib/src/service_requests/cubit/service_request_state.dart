part of 'service_request_cubit.dart';

class ServiceRequestState extends Equatable {
  const ServiceRequestState({
    this.user = User.empty,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final User user;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [user, status];

  ServiceRequestState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return ServiceRequestState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
