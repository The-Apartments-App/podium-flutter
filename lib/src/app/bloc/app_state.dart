part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

enum AppPage {
  userHome,
  userSettings,
  userDocuments,
  userPayments,
  serviceRequest
}

class AppState extends Equatable {
  const AppState._(
      {required this.status,
      this.user = User.empty,
      this.page = AppPage.userHome,
      }
  );

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  AppState.userHome(User user)
      : this._(
          page: AppPage.userHome,
          status: user.isNotEmpty ?
            AppStatus.authenticated : AppStatus.unauthenticated,
          user: user
        ,);

  AppState.userSettings(User user)
      : this._(
          page: AppPage.userSettings,
          status: user.isNotEmpty ?
            AppStatus.authenticated : AppStatus.unauthenticated,
          user: user
        ,);

  AppState.userDocuments(User user)
    : this._(
        page: AppPage.userDocuments,
        status: user.isNotEmpty ?
          AppStatus.authenticated : AppStatus.unauthenticated,
        user: user
      ,);

    AppState.userPayments(User user)
      : this._(
          page: AppPage.userPayments,
          status: user.isNotEmpty ?
            AppStatus.authenticated : AppStatus.unauthenticated,
          user: user
        ,);

    AppState.serviceRequest(User user)
      : this._(
          page: AppPage.serviceRequest,
          status: user.isNotEmpty ?
            AppStatus.authenticated : AppStatus.unauthenticated,
          user: user
        ,);


  final AppStatus status;
  final User user;
  final AppPage page;

  @override
  List<Object> get props => [status, user, page];
}
