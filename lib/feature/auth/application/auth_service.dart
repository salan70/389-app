import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/logger.dart';
import '../../app_review/application/app_review_state.dart';
import '../../app_review/domain/review_history_repository.dart';
import '../domain/auth_repository.dart';
import '../domain/user_info_repository.dart';

/// userサービスプロバイダー
final authServiceProvider = Provider(AuthService.new);

/// Auth関連の処理を行うサービスクラス
class AuthService {
  const AuthService(this.ref);

  final Ref ref;

  /// ログインを行う（アプリ起動時に呼ぶ）。
  ///
  /// 現在の [User] を取得し、nullだったら匿名ユーザーを作成する。
  Future<void> login() async {
    final authRepository = ref.read(authRepositoryProvider);

    // ログイン済みでない場合、匿名ユーザーを作成する。
    if (authRepository.getCurrentUser() == null) {
      logger.i('ログインしていないため、匿名ユーザーを作成します。');
      await authRepository.signInAnonymously();
    }

    // 匿名ユーザーを作成した場合でも、ここで user を取得できる想定。
    final user = ref.read(authRepositoryProvider).getCurrentUser()!;
    logger.i('ログインしました。uid: ${user.uid}');

    // userInfo を更新する。
    await _updateUserInfo(user);

    // reviewHistory が存在しない場合、作成する。
    await _maybeCreateReviewHistory(user);
  }

  Future<void> _maybeCreateReviewHistory(User user) async {
    final reviewHistory = await ref.read(reviewHistoryProvider.future);
    if (reviewHistory == null) {
      await ref.read(reviewHistoryRepositoryProvider).create(user.uid);
    }
  }

  /// userInfo を更新する。
  Future<void> _updateUserInfo(User user) async =>
      ref.read(userInfoRepositoryProvider).updateUserInfo(user);
}
