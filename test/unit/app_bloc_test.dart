import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podium/src/app/app.dart';

void main() {
  group('AppBloc', () {
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
