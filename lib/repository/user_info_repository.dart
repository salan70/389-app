import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoRepositoryProvider = Provider<UserInfoRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class UserInfoRepository {
  /// ユーザー情報を作成
  Future<void> createUserInfo();

  /// ユーザー情報を取得
  Future<void> fetchUserInfo();

  /// ユーザー情報を削除
  Future<void> deleteUserInfo();
}
