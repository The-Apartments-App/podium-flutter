part of 'update_profile_photo_cubit.dart';

class UpdateProfilePhotoState extends Equatable {
  const UpdateProfilePhotoState({
    this.profilePicture,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Image? profilePicture;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [status, profilePicture!];

  UpdateProfilePhotoState copyWith({
    Image? profilePicture,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return UpdateProfilePhotoState(
      profilePicture: profilePicture ?? this.profilePicture,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
