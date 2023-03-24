part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

enum AppPage {
  userLogin,
  userHome,
  userSettings,
  userDocuments,
  userPayments,
  serviceRequest,
  buildingAmenities
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.page = AppPage.userLogin,
  });

  const AppState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
          page: AppPage.userHome,
        );

  const AppState.unauthenticated()
      : this._(status: AppStatus.unauthenticated, page: AppPage.userLogin);

  const AppState.userLogin(User user)
      : this._(
          page: AppPage.userLogin,
          status: AppStatus.unauthenticated,
          user: user,
        );

  AppState.userHome(User user)
      : this._(
          page: AppPage.userHome,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  AppState.userSettings(User user)
      : this._(
          page: AppPage.userSettings,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  AppState.userDocuments(User user)
      : this._(
          page: AppPage.userDocuments,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  AppState.userPayments(User user)
      : this._(
          page: AppPage.userPayments,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  AppState.serviceRequest(User user)
      : this._(
          page: AppPage.serviceRequest,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );
  AppState.buildingAmenities(User user)
      : this._(
          page: AppPage.buildingAmenities,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  final AppStatus status;
  final User user;
  final AppPage page;

  @override
  List<Object> get props => [status, user, page];
}
