import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class AuthRepository {
  /// 現在サインインしているユーザーを取得する
  User? getCurrentUser();

  /// サインイン（匿名ユーザーを作成）
  Future<void> signInAnonymously();
  
}
