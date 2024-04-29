import 'package:firebase_auth/firebase_auth.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

///can be used for throwing [NoInternetException]
class NoInternetException implements Exception {
  late String _message;

  NoInternetException([String message = 'NoInternetException Occurred']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

class AuthExceptionHandler {
  static String handleException(FirebaseAuthException e) {
    print(e.code);
    String errorMessage = '';
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'Invalid email address.';
        break;
      case 'user-disabled':
        errorMessage = 'User account has been disabled.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found with this email.';
        break;
      case 'wrong-password':
        errorMessage = 'Invalid password provided.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Try again later.';
        break;
      case 'network-request-failed':
        errorMessage = 'Network error. Check your connection.';
        break;
      case 'email-already-in-use':
        errorMessage = 'Email address is already in use.';
        break;
      case 'invalid-credential':
        errorMessage = 'Invalid Credential';
        break;
      default:
        errorMessage = 'Login failed. Please try again.';
    }
    return errorMessage;
  }
}
