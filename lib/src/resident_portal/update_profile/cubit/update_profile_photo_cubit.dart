import 'dart:io';
import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:podium/src/login/models/models.dart';
import 'package:podium/src/login/models/username.dart';
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
    try {
      await _authenticationRepository.updateProfilePicture(
        photo: picture,
      );
    } catch (_) {
      debugPrint('ERROR');
    }
  }
}
