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

  Future<void> logInWithDemoResidentUser() async {
    await _authenticationRepository.logInWithEmailAndPassword(
      email: 'demouser@podiumapartments.com',
      password: 'demopassword',
    );
  }

  Future<void> logInWithDemoAdminUser() async {
    await _authenticationRepository.logInWithEmailAndPassword(
      email: 'demoadminuser@podiumapartments.com',
      password: 'demoadminpassword',
    );
  }

  Future<void> logInWithGoogle() async {
    debugPrint('loginWithGoogle called in login_cubit.dart');
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      debugPrint('before await authRepo.logInWithGoogle');
      await _authenticationRepository.logInWithGoogle();
      final user = _authenticationRepository.currentUser;
      debugPrint('user after login with google: $user');
      debugPrint('after await authRepo.logInWithGoogle');
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      debugPrint(e.message);
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      debugPrint('something bad happened.: $error');
    }
  }

  Future<void> logInWithFacebook() async {
    debugPrint('loginWithFacebook called in login_cubit.dart');
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      debugPrint('before await authRepo.logInWithFacebook');
      await _authenticationRepository.signInWithFacebook();
      debugPrint('after await authRepo.logInWithFacebook');
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

  Future<void> logOut() async {
    await _authenticationRepository.logOut();
  }
}
