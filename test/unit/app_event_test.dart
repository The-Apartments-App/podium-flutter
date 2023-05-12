import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podium/src/app/app.dart';

void main() {
  group('AppEvent', () {
    test('AppLogoutRequested should have empty props', () {
      final event = AppLogoutRequested();
      expect(event.props, isEmpty);
    });

    test('AppUserChanged should have user in its props', () {
      const user = User(id: 'testing_id', name: 'Test User');
      const event = AppUserChanged(user);
      expect(event.props, [user]);
    });
  });
}
