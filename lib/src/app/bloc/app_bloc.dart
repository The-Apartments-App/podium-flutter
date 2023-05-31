import 'dart:async';

import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  // This class is responsible for managing the app state
  // and transitions between app pages.
  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        _supabase = Supabase.instance,
        super(
          // Set the initial state of the app based on whether
          // a user is currently logged in.

          // If a user is logged in, set the app state to authenticated,
          // with the current user data.

          // Otherwise, set the app state to unauthenticated.
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    // Set up event handlers for the app bloc.
    // The on method takes an event type and a callback function
    // to be executed when that event is received.
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _supabase.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;
      debugPrint('userSubscripton session: $session');
      debugPrint('userSubscripton event: $event');
    });
  }

  // Instance variables for the app bloc.
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AuthState> _userSubscription;
  final Supabase _supabase;

  // Callback function to be executed when a user changed event is received.
  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      // If a user is logged in, set the app state to authenticated,
      // with the new user data.
      // Otherwise, set the app state to unauthenticated.
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  // Callback function to be executed when a logout requested event is received.
  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    // Log the user out of the app and return to the login page.
    unawaited(_authenticationRepository.logOut());
  }

  // Clean up resources when the app bloc is closed.
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
