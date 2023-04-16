part of 'app_bloc.dart';

// Abstract class representing events that can occur within the app
abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

// Event representing a request to log out of the app
class AppLogoutRequested extends AppEvent {}

// Event representing a change in the user's authentication status
class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

// Event representing a change in the currently displayed page within the app
class AppPageChanged extends AppEvent {
  const AppPageChanged(this.page, this.user);

  final AppPage page;
  final User user;

  @override
  List<Object> get props => [page, user];
}
