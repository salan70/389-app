import 'package:common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app_review/application/app_review_state.dart';
import '../../app_review/infrastructure/review_history_repository.dart';
import '../infrastructure/auth_repository.dart';
import '../infrastructure/user_info_repository.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) => AuthService(ref);

/// Auth 関連の処理を行うサービスクラス。
class AuthService {
  const AuthService(this.ref);

  final Ref ref;

  /// ログインを行う（アプリ起動時に呼ぶ）。
  ///
  /// 現在の [User] を取得し、nullだったら匿名ユーザーを作成する。
  Future<void> login() async {
    // 未ログインの場合、匿名ユーザーとしてログインする。
    await _maybeSignInAnonymously();

    // 現在のユーザーを取得する。
    final currentUser = ref.read(authRepositoryProvider).getCurrentUser()!;
    logger.i('ログインしました。uid: ${currentUser.uid}');

    // userInfo を更新する。
    await _updateUserInfo(currentUser);

    // reviewHistory が存在しない場合、作成する。
    await _maybeCreateReviewHistory(currentUser);
  }

  /// 未ログインの場合、匿名ユーザーとしてログインする。
  /// （匿名ユーザーを作成する。）
  Future<void> _maybeSignInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    final currentUser = authRepository.getCurrentUser();

    // ログイン済みでない場合、匿名ユーザーを作成する。
    if (currentUser == null) {
      logger.i('ログインしていないため、匿名ユーザーを作成します。');
      await authRepository.signInAnonymously();
    }
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
