import 'dart:async';
import 'package:authentication_repo/authentication_repo.dart';
import 'package:cache/cache.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

/// {@template sign_up_with_email_and_password_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    Supabase? supabase,
  })  : _cache = cache ?? CacheClient(),
        _supabase = supabase ?? Supabase.instance;

  final CacheClient _cache;
  final Supabase _supabase;

  /// User cache key.
  static const _userCacheKey = '__user_cache_key__';

  // Stream<User> get user {
  //   debugPrint('this line is executed');
  //   return _supabase.client.auth.onAuthStateChange.map((event) {
  //     debugPrint('but we never get here......');
  //     final supabaseUser = event.session?.user;
  //     debugPrint('supabaseUser: $supabaseUser');
  //     final user = supabaseUser ?? User.empty;
  //     _cache.write(key: _userCacheKey, value: user);
  //     return user as User;
  //   });
  // }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: _userCacheKey) ?? User.empty;
  }

  /// Clears the current cached user by setting the user cache key
  /// to an empty string and the cached user to [User.empty].
  void clearUser() {
    return _cache.write<User>(key: '', value: User.empty);
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _supabase.client.auth.signUp(
        email: email,
        password: password,
      );
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> checkEmailValidity({required String email}) async {
    try {
      final response = await _supabase.client
          .from('users')
          .select()
          .eq('email', email)
          .limit(1);

      final data = response.data as List<dynamic>;

      if (data.isNotEmpty) {
        final signInMethod = data[0];
        switch (signInMethod) {
          case 'facebook.com':
            debugPrint('Signing in with Facebook');
            await _supabase.client.auth.signInWithOAuth(Provider.facebook);
            break;
          case 'google.com':
            debugPrint('Signing in with Google');
            await _supabase.client.auth.signInWithOAuth(Provider.google);
            break;
          case 'apple.com':
            debugPrint('Signing in with Apple');
            break;
          default:
            debugPrint('Invalid sign-in method');
        }
      }
    } catch (error) {
      debugPrint('checkEmailValidity error: $error');
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _supabase.client.auth.signOut();
    } catch (_) {
      debugPrint('Error signing out.');
      throw LogOutFailure();
    }
  }

  /// Updates the current user's profile information.
  ///
  /// The [email], [password], [displayName],
  ///  and [photoURL] parameters are required.
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure]
  /// if an exception occurs while updating the user profile.
  Future<void> updateProfile({
    required String email,
    required String password,
    required String displayName,
    required String photoURL,
  }) async {
    debugPrint('UPDATE PROFILE CALLED');
    try {
      if (_supabase.client.auth.currentUser != null) {
        await _supabase.client.auth.updateUser(
          UserAttributes(
            email: email,
            password: password,
            data: {
              'profilePicture': photoURL,
              'displayName': displayName,
            },
          ),
        );
      }
    } catch (error) {
      debugPrint('An error occured attempting to update the user profile.');
      debugPrint('Error: $error');
    }
  }
}
