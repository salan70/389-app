// ignore_for_file: one_member_abstracts

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoRepositoryProvider = Provider<UserInfoRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class UserInfoRepository {
  /// ユーザー情報を作成する
  Future<void> updateUserInfo(User user);

  /// 指定したdailyQuizの結果が存在するかどうかを返す
  Future<bool> existSpecifiedDailyQuizResult(User user, String dailyQuizId);
}
