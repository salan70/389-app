import 'package:firebase_auth/firebase_auth.dart';

import '../auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  @override
  User? getCurrentUser() {
    try {
      return firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      await firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // TODO(me): エラーハンドリング
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // サインアウト
      await firebaseAuth.signOut();
      // 匿名でサインイン
      await signInAnonymously();
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(User user) async {
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }
}
