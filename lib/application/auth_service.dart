import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/base_repository/auth_repository.dart';

/// authサービスプロバイダー
final authServiceProvider = Provider(
  AuthService.new,
);

/// authサービス
///
/// authに関する操作を提供する
/// Widget から呼ばれ、各 Repository や State を操作するロジックを実装する
class AuthService {
  const AuthService(this.ref);

  final Ref ref;

  /// アプリ起動時に呼ぶ
  /// 現在のUserを取得し、nullだったら匿名ユーザーを作成、登録する
  Future<void> createUser() async {
    final authRepository = ref.read(authRepositoryProvider);

    // ログイン済みなら何もしない
    final user = authRepository.getCurrentUser();
    if (user != null) {
      return;
    }

    await authRepository.signInAnonymously();
    // TODO(me): UserInfoをFireStoreに保存
  }
}
