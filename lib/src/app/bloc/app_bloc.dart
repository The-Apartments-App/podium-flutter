import 'dart:async';

import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
    on<AppPageChanged>(_onAppPageChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void _onAppPageChanged(AppPageChanged event, Emitter<AppState> emit) {
    switch (event.page) {
      case AppPage.userLogin:
        return emit(
          AppState.userLogin(event.user),
        );
      case AppPage.userHome:
        return emit(
          AppState.userHome(event.user),
        );
      case AppPage.userDocuments:
        return emit(
          AppState.userDocuments(event.user),
        );
      case AppPage.userSettings:
        return emit(
          AppState.userSettings(event.user),
        );
      case AppPage.userPayments:
        return emit(
          AppState.userPayments(event.user),
        );
      case AppPage.serviceRequest:
        return emit(
          AppState.serviceRequest(event.user),
        );
      case AppPage.buildingAmenities:
        return emit(
          AppState.buildingAmenities(event.user),
        );
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
