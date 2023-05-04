// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState({
    // this.email = const Email.pure(),
    // this.password = const Password.pure(),
    this.userName = const Username.pure(),
    // this.profilePicture,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  // final Email email;
  // final Password password;
  final Username userName;
  // final Image? profilePicture;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  @override
  List<Object> get props =>
      [status, userName];

  UpdateProfileState copyWith({
    // Email? email,
    // Password? password,
    Username? userName,
    // Image? profilePicture,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    debugPrint('PROFILE STATE UPDATE');
    // debugPrint('NEW VALUE: email: $email');
    // debugPrint('NEW VALUE: password: $password');
    // debugPrint('NEW VALUE: profilePicture: $profilePicture');
    debugPrint('NEW VALUE: userName: $userName');
    debugPrint('NEW VALUE: status: $status');
    return UpdateProfileState(
      // email: email ?? this.email,
      // password: password ?? this.password,
      // profilePicture: profilePicture ?? this.profilePicture,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
