import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/hitter_quiz_result.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/user_info_repository.dart';

/// nomalQuizResultListを返すプロバイダー
final normalQuizResultListStateProvider =
    FutureProvider.autoDispose<List<HitterQuizResult>>((ref) {
  return ref.read(userInfoRepositoryProvider).fetchNormalQuizResultList(
        ref.read(authRepositoryProvider).getCurrentUser()!,
      );
});
