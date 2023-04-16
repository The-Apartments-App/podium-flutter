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

// This is the AppState class, which is used to represent the state of the app
class AppState extends Equatable {
  // This is the private constructor for AppState
  // that takes in the AppStatus, User, and AppPage
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.page = AppPage.userLogin,
  });

  // This is a public constructor for
  // an authenticated AppState that takes in a User
  const AppState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
          page: AppPage.userHome,
        );

  // This is a public constructor for an unauthenticated AppState
  const AppState.unauthenticated()
      : this._(status: AppStatus.unauthenticated, page: AppPage.userLogin);

  // This is a public constructor for an AppState
  // representing the user login page that takes in a User
  const AppState.userLogin(User user)
      : this._(
          page: AppPage.userLogin,
          status: AppStatus.unauthenticated,
          user: user,
        );

  // This is a public constructor for an AppState
  // representing the user home page that takes in a User
  AppState.userHome(User user)
      : this._(
          page: AppPage.userHome,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  // This is a public constructor for an AppState
  // representing the user settings page that takes in a User
  AppState.userSettings(User user)
      : this._(
          page: AppPage.userSettings,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  // This is a public constructor for an AppState
  // representing the user documents page that takes in a User
  AppState.userDocuments(User user)
      : this._(
          page: AppPage.userDocuments,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  // This is a public constructor for an AppState
  // representing the user payments page that takes in a User
  AppState.userPayments(User user)
      : this._(
          page: AppPage.userPayments,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  // This is a public constructor for an AppState
  // representing the service request page that takes in a User
  AppState.serviceRequest(User user)
      : this._(
          page: AppPage.serviceRequest,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  // This is a public constructor for an AppState
  // representing the building amenities page that takes in a User
  AppState.buildingAmenities(User user)
      : this._(
          page: AppPage.buildingAmenities,
          status: user.isNotEmpty
              ? AppStatus.authenticated
              : AppStatus.unauthenticated,
          user: user,
        );

  // These are the final properties for the AppState
  final AppStatus status;
  final User user;
  final AppPage page;

  // This is an override of the Equatable class's get props method,
  // which returns the list of properties
  // used to compare two objects for equality
  @override
  List<Object> get props => [status, user, page];
}
