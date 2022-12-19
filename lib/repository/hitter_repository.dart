import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/hitter_search_condition.dart';
import '../model/ui/hitter_id_by_name.dart';
import '../model/ui/hitter_quiz_ui.dart';

final hitterRepositoryProvider = Provider<HitterRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class HitterRepository {
  // 検索条件に合う野手を1人取得する
  Future<HitterQuizUi?> implSearchHitter(
    HitterSearchCondition searchCondition,
  );

  // 登録されている全ての野手を取得する
  Future<List<HitterIdByName>> fetchAllHitter();
}