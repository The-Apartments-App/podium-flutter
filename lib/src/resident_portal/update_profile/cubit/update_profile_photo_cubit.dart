import 'dart:io';
import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'update_profile_photo_state.dart';


class UpdateProfilePhotoCubit extends Cubit<UpdateProfilePhotoState> {
  UpdateProfilePhotoCubit(this._authenticationRepository)
      : super(const UpdateProfilePhotoState());

  final AuthenticationRepository _authenticationRepository;

  // copies the profile photo upload state
  void profilePictureChanged(Image value) {
    final picture = value;
    emit(
      state.copyWith(
        profilePicture: picture,
      ),
    );
  }

  // Function to update profile using the picture in form state
  Future<void> updateWithNewPicture(File? picture) async {
    debugPrint('UPDATEWITHNEWPICTURE CALLED IN UpdateProfileCubit');
    debugPrint('picture in updateWithNewPicture: $picture');
    // if (!kIsWeb) {
      try {
        await _authenticationRepository.updateProfilePicture(
          photo: picture,
        );
      } catch (_) {
        debugPrint('ERROR');
      }
    // } else {
    //      try {
    //     await _authenticationRepository.updateProfilePicture(
    //       // photo: imagedPicture,
    //     );
    //   } catch (_) {
    //     debugPrint('ERROR');
    //   }
    // }
  }

//     Future<void> updateWithNewPictureBlob(html.Blob? picture) async {
//     debugPrint('UPDATEWITHNEWPICTURE CALLED IN UpdateProfileCubit');
//     debugPrint('picture in updateWithNewPicture: $picture');
//     // if (!kIsWeb) {
//       try {
//         await _authenticationRepository.updateProfileWithBlobPicture(
//           photo: picture,
//         );
//       } catch (_) {
//         debugPrint('ERROR');
//       }
//     // }
//   }
}
