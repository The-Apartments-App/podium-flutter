import 'dart:io';

import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

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
    try {
      await _authenticationRepository.updateProfilePicture(
        photo: picture,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateWithNewPictureWeb(String path) async {
    final imageData = await XFile(path).readAsBytes();
    try {
      await _authenticationRepository.updateProfileWithWebPicture(
        imageData: imageData,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
