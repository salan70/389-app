import 'package:common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  @override
  User? getCurrentUser() {
    try {
      return firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw e.toAuthException();
    }
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      await firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw e.toAuthException();
    }
  }
}

extension _FirebaseAuthExceptionEx on FirebaseAuthException {
  /// FirebaseAuthException => AuthException
  AuthException toAuthException() {
    switch (code) {
      case 'invalid-email':
        return AuthException.invalidEmail();
      case 'wrong-password':
        return AuthException.wrongPassword();
      case 'weak-password':
        return AuthException.weakPassword();
      case 'user-not-found':
        return AuthException.userNotFound();
      case 'user-disabled':
        return AuthException.userDisabled();
      case 'too-many-requests':
        return AuthException.tooManyRequests();
      case 'operation-not-allowed':
        return AuthException.operationNotAllowed();
      case 'network-request-failed':
        return AuthException.networkRequestFailed();
      case 'email-already-in-use':
      case 'credential-already-in-use':
        return AuthException.emailAlreadyInUse();
      case 'user-mismatch':
        return AuthException.userMismatch();
      case 'invalid-action-code':
        return AuthException.invalidActionCode();
      case 'invalid-credential':
        return AuthException.invalidCredential();
      case 'requires-recent-login':
        return AuthException.requiresRecentLogin();
      case 'internal-error':
      case 'unknown':
        return AuthException.unknown();
      default:
        logger.w(this);
        return AuthException.unknown();
    }
  }
}
