import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podium/src/app/app.dart';

void main() {
  group('AppBloc', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });
    test('initial state is correct', () {
      final appBloc =
          AppBloc(authenticationRepository: authenticationRepository);
      expect(appBloc.state, const AppState.unauthenticated());
      appBloc.close();
    });

    blocTest<AppBloc, AppState>(
      'emits [authenticated] when AppUserChanged with non-empty user is added',
      build: () => AppBloc(authenticationRepository: authenticationRepository),
      act: (bloc) => bloc.add(const AppUserChanged(User(id: '1'))),
      expect: () => [const AppState.authenticated(User(id: '1'))],
    );

    blocTest<AppBloc, AppState>(
      'emits [unauthenticated] when AppUserChanged with empty user is added',
      build: () => AppBloc(authenticationRepository: authenticationRepository),
      act: (bloc) => bloc.add(const AppUserChanged(User.empty)),
      expect: () => [const AppState.unauthenticated()],
    );

    blocTest<AppBloc, AppState>(
      'does not emit when AppUserChanged with same user is added',
      build: () => AppBloc(authenticationRepository: authenticationRepository),
      seed: () => const AppState.authenticated(User(id: '1')),
      act: (bloc) => bloc.add(const AppUserChanged(User(id: '1'))),
      expect: () => <dynamic>[],
    );

    blocTest<AppBloc, AppState>(
      'does not emit when AppLogoutRequested is added',
      build: () => AppBloc(authenticationRepository: authenticationRepository),
      seed: () => const AppState.authenticated(User(id: '1')),
      act: (bloc) => bloc.add(AppLogoutRequested()),
      expect: () => <dynamic>[],
    );

    test(
        '''calls logOut on authenticationRepository when AppLogoutRequested is added''',
        () {
      final appBloc =
          AppBloc(authenticationRepository: authenticationRepository)
            ..add(AppLogoutRequested());
      expect(authenticationRepository.currentUser.isEmpty, isTrue);
      appBloc.close();
    });

    test('AppLogoutRequested should have empty props', () {
      final event = AppLogoutRequested();
      expect(event.props, isEmpty);
    });

    test('AppUserChanged should have user in its props', () {
      const user = User(id: 'testing_id', name: 'Test User');
      const event = AppUserChanged(user);
      expect(event.props, [user]);
    });

    test('authenticated AppState should have AppStatus.authenticated and user',
        () {
      const user = User(id: 'testing_id', name: 'Test User');
      const state = AppState.authenticated(user);
      expect(state.status, equals(AppStatus.authenticated));
      expect(state.user, equals(user));
    });

    test(
        '''unauthenticated AppState should have AppStatus.unauthenticated and empty user''',
        () {
      const state = AppState.unauthenticated();
      expect(state.status, equals(AppStatus.unauthenticated));
      expect(state.user, equals(User.empty));
    });

    test('props should return the correct list of properties', () {
      const user1 = User(id: 'testing_id1', name: 'Test User 1');
      const user2 = User(id: 'testing_id2', name: 'Test User 2');

      const state1 = AppState.authenticated(user1);
      const state2 = AppState.authenticated(user1);
      const state3 = AppState.authenticated(user2);
      const state4 = AppState.unauthenticated();

      expect(state1.props, equals([AppStatus.authenticated, user1]));
      expect(state2.props, equals([AppStatus.authenticated, user1]));
      expect(state3.props, equals([AppStatus.authenticated, user2]));
      expect(state4.props, equals([AppStatus.unauthenticated, User.empty]));
    });
  });
}

class MockAuthenticationRepository extends Fake
    implements AuthenticationRepository {
  @override
  final currentUser = User.empty;

  @override
  Stream<User> get user => const Stream.empty();

  Future<void> logIn({required String username, required String password}) =>
      Future.value();

  @override
  Future<void> logOut() => Future.value();
}
