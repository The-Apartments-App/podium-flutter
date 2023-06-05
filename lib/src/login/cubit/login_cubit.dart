import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }

  void returnToEmail() {
    emit(
      state.copyWith(
        emailIsValid: false,
      ),
    );
  }

  Future<void> checkEmailValidity() async {
    debugPrint('checkEmail validity called in login_cubit.dart');
    if (state.email.isNotValid) return;
    try {
      await _authenticationRepository.checkEmailValidity(
        email: state.email.value,
      );
      emit(state.copyWith(emailIsValid: true));
      debugPrint('state in checkEmailValidity: ${state.emailIsValid}');
    } catch (error) {
      debugPrint('error in checkEmailValidity: $error');
    }
  }

  Future<void> logInWithCredentials() async {
    if (state.status.isCanceled) return;
    try {
      debugPrint('before await authRepo.logInWithEmailAndPassword');
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      debugPrint('LogInWithEmailAndPasswordFailure.message: ${e.message}');
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

  Future<void> logInWithDemoUser() async {
    await _authenticationRepository.logInWithEmailAndPassword(
      email: 'demouser@podiumapartments.com',
      password: 'demopassword',
    );
  }

  Future<void> logOut() async {
    await _authenticationRepository.logOut();
  }
}
