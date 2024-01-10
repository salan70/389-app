import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    throw UnimplementedError('Provider was not initialized');

abstract class AuthRepository {
  /// 現在サインインしているユーザーを取得する
  User? getCurrentUser();

  /// サインイン（匿名ユーザーを作成）
  Future<void> signInAnonymously();
}
