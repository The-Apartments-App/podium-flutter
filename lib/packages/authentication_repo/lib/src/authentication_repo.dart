import 'dart:async';
import 'dart:io';

import 'package:authentication_repo/authentication_repo.dart';
import 'package:cache/cache.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:podium/src/resident_portal/update_profile/screens/update_profile_display_name_page.dart';

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
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  final bool _isWeb = kIsWeb;

  /// User cache key.
  static const _userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state or the user profile is changed.
  /// 
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.userChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: _userCacheKey, value: user);
      return user;
    });
  }

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
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;

      // Check if app is running on web or mobile
      if (_isWeb) {
        // Use Firebase GoogleAuthProvider to authenticate user via popup
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        // Use GoogleSignIn to authenticate user on mobile
        final googleUser = await _googleSignIn.signIn();

        // Print information about the Google user for debugging purposes
        debugPrint('this is googleUser: $googleUser');

        // Obtain user's authentication information
        final googleAuth = await googleUser!.authentication;

        // Use Firebase GoogleAuthProvider to create AuthCredential
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      // Sign in with Firebase AuthCredential
      await _firebaseAuth.signInWithCredential(credential);
    } // Handle Firebase Authentication exceptions if they occur
    on FirebaseAuthException catch (e) {
      // Output the error message to the console for debugging purposes
      debugPrint('error in loginwithgoogle: $e');
      // Throw a custom exception with the same error code to
      // handle it in a more user-friendly way
      throw LogInWithGoogleFailure.fromCode(e.code);
    }
// Handle other exceptions if they occur
    catch (_) {
      // Throw a custom exception to handle it in a more user-friendly way
      throw const LogInWithGoogleFailure();
    }
  }

  /// Starts the Sign In with Facebook flow.
  ///
  /// Throws an exception if an error occurs during the sign in process.
  Future<void> signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        debugPrint('result.status is success');
        final credential = firebase_auth.FacebookAuthProvider.credential(
          result.accessToken!.token,
        );
        await _firebaseAuth.signInWithCredential(credential);
      }
    } on Exception catch (e) {
      debugPrint('this is the error: $e');
      // Catching any exceptions that occur during the Facebook sign in process.
    }
  }

  /// Checks if the [email] provided is already in use by another account
  ///
  /// If the email is already in use, it attempts to sign in the user using the
  /// corresponding authentication provider. If the sign-in fails, an error is
  /// logged.
  ///
  /// Throws an error if the operation fails.
  Future<void> checkEmailValidity({required String email}) async {
    try {
      final data = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (data.isNotEmpty) {
        final signInMethod = data[0];
        switch (signInMethod) {
          case 'facebook.com':
            debugPrint('Signing in with Facebook');
            await signInWithFacebook();
            break;
          case 'google.com':
            debugPrint('Signing in with Google');
            await logInWithGoogle();
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
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
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
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
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
      if (_firebaseAuth.currentUser != null) {
        // Update the current user's email
        await _firebaseAuth.currentUser?.updateEmail(email);

        // Update the current user's password
        await _firebaseAuth.currentUser?.updatePassword(password);

        // Update the current user's display name
        await _firebaseAuth.currentUser?.updateDisplayName(displayName);

        // Update the current user's photo URL
        await _firebaseAuth.currentUser?.updatePhotoURL(photoURL);
      }
    } on FirebaseAuthException catch (e) {
      // If an exception occurs while updating the user profile,
      // throw a SignUpWithEmailAndPasswordFailure
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      // If an unknown exception occurs while updating the user profile,
      // throw a SignUpWithEmailAndPasswordFailure
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  // change the logged in users name
  Future<void> changeDisplayName({required String displayName}) async {
    debugPrint('UPDATE DISPLAY NAME CALLED');

    final firebaseUser = _firebaseAuth.currentUser;
    try {
      await firebaseUser?.updateDisplayName(displayName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // change the logged in users photo
  Future<void> updateProfilePicture({
    File? photo,
  }) async {
    debugPrint('UPDATE PROFILE PICTURE CALLED');
    debugPrint('NEW PHOTO IS $photo');
    try {
      if (_firebaseAuth.currentUser != null) {
        debugPrint('currentUser is not null');
        final storageRef = FirebaseStorage.instance.ref();
        debugPrint('storageRef: $storageRef');
        final userImageRef = storageRef
            .child('users/${currentUser.id}/images/photoURL.jpg');
        debugPrint('userImageRef: $userImageRef');
        if (photo != null) {
          await userImageRef.putFile(photo);
        } else {
          throw Exception('Error putting file in cloud');
        }
        final profileUrl = await userImageRef.getDownloadURL();
        debugPrint('profileUrl: $profileUrl');

        await _firebaseAuth.currentUser?.updatePhotoURL(profileUrl);
        debugPrint('Firebase Auth updated ------------');
      }
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }
}

/// This extension method adds a convenient way
///  to convert a [firebase_auth.User]
/// object to a [User] object in our application domain model.
///
/// The [toUser] method returns a new [User] object that contains the user's
/// ID, email, display name, and photo URL.
extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
