part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

// This is the AppState class, which is used to represent the state of the app
class AppState extends Equatable {
  // This is the private constructor for AppState
  // that takes in the AppStatus, and User
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  // This is a public constructor for
  // an authenticated AppState that takes in a User
  const AppState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  // This is a public constructor for an unauthenticated AppState
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  // These are the final properties for the AppState
  final AppStatus status;
  final User user;

  // This is an override of the Equatable class's get props method,
  // which returns the list of properties
  // used to compare two objects for equality
  @override
  List<Object> get props => [status, user];
}
