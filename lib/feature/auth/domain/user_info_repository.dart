// ignore_for_file: one_member_abstracts

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_repository.g.dart';

@riverpod
UserInfoRepository userInfoRepository(UserInfoRepositoryRef ref) =>
    throw UnimplementedError('Provider was not initialized');

abstract class UserInfoRepository {
  /// ユーザー情報を作成 / 更新する。
  Future<void> updateUserInfo(User user);
}
