part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class AppPageChanged extends AppEvent {
  const AppPageChanged(this.page, this.user);

  final AppPage page;
  final User user;

  @override
  List<Object> get props => [page, user];
}