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

  // copy to update profile name form state
  void userNameChanged(String value) {
    debugPrint('passed value in cubit $value');  
    final newUsername = Username.dirty(value);
    emit(
      state.copyWith(
        userName: newUsername,
      ),
    );
  }

  // cubit function for changing name
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

  // Future<void> logInWithGoogle() async {
  //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
  //   try {
  //     await _authenticationRepository.logInWithGoogle();
  //     emit(state.copyWith(status: FormzSubmissionStatus.success));
  //   } on LogInWithGoogleFailure catch (e) {
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
}
