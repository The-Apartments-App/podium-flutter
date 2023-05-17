// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_profile_name_cubit.dart';

class UpdateProfileNameState extends Equatable {
  const UpdateProfileNameState({
    this.userName = const Username.pure(),
    this.profilePicture,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Username userName;
  final Image? profilePicture;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [status, userName];

  UpdateProfileNameState copyWith({
    Username? userName,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return UpdateProfileNameState(
      userName: userName ?? this.userName,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
