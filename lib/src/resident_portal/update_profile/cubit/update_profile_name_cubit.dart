import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
      emit(
        state.copyWith(
          userName: Username.dirty(name),
          status: FormzSubmissionStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure,));
      throw Exception(e.toString());
    }
  }
}
