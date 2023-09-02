import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/auth_repository.dart';
import '../domain/user_info_repository.dart';

/// userサービスプロバイダー
final authServiceProvider = Provider(AuthService.new);

/// Auth関連の処理を行うサービスクラス
class AuthService {
  const AuthService(this.ref);

  final Ref ref;

  /// ログインを行う（アプリ起動時に呼ぶ）
  /// 現在のUserを取得し、nullだったら匿名ユーザーを作成する
  Future<void> login() async {
    final authRepository = ref.read(authRepositoryProvider);

    // ログイン済み出ない場合、匿名ユーザーを作成する
    final user = authRepository.getCurrentUser();
    if (user == null) {
      await authRepository.signInAnonymously();
    }

    // userInfoを更新する
    await _updateUserInfo();
  }

  /// userInfoを更新する
  Future<void> _updateUserInfo() async {
    final user = ref.read(authRepositoryProvider).getCurrentUser();
    final userInfoRepository = ref.read(userInfoRepositoryProvider);

    await userInfoRepository.updateUserInfo(user!);
  }
}
