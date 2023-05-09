import 'dart:io';
import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:podium/src/login/models/models.dart';
import 'package:podium/src/login/models/username.dart';
part 'update_profile_name_state.dart';

class UpdateProfileNameCubit extends Cubit<UpdateProfileNameState> {
  UpdateProfileNameCubit(this._authenticationRepository)
      : super(const UpdateProfileNameState());

  final AuthenticationRepository _authenticationRepository;

  // void emailChanged(String value) {
  //   final email = Email.dirty(value);
  //   emit(
  //     state.copyWith(
  //       email: email,
  //     ),
  //   );
  // }

  // void passwordChanged(String value) {
  //   final password = Password.dirty(value);
  //   emit(
  //     state.copyWith(
  //       password: password,
  //     ),
  //   );
  // }

  void userNameChanged(String value) {
    debugPrint('passed value in cubit $value');  
    final newUsername = Username.dirty(value);
    emit(
      state.copyWith(
        userName: newUsername,
      ),
    );
  }

  Future<void> updateWithNewDisplayName(String name) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.changeDisplayName(displayName: name);
      emit(state.copyWith(
        userName: Username.dirty(name),
        status: FormzSubmissionStatus.success,),
        );
    } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  // void profilePictureChanged(Image value) {
  //   final picture = ProfilePicture.dirty(value);
  //   emit(
  //     state.copyWith(
  //       profilePicture: picture,
  //     ),
  //   );
  // }

  // Future<void> logInWithCredentials() async {
  //   if (!state.status.isCanceled) return;
  //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
  //   try {
  //     await _authenticationRepository.logInWithEmailAndPassword(
  //       email: state.email.value,
  //       password: state.password.value,
  //     );
  //     emit(state.copyWith(status: FormzSubmissionStatus.success));
  //   } on LogInWithEmailAndPasswordFailure catch (e) {
  //     emit(
  //       state.copyWith(
  //         errorMessage: e.message,
  //         status: FormzSubmissionStatus.failure,
  //       ),
  //     );
  //   } catch (_) {
  //     emit(state.copyWith(status: FormzSubmissionStatus.failure));
  //   }
  // }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

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
