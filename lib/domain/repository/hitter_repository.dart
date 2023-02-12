import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/hitter_id_by_name.dart';
import '../entity/hitter_quiz_ui.dart';
import '../entity/hitter_search_condition.dart';

final hitterRepositoryProvider = Provider<HitterRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class HitterRepository {
  /// 検索条件に合う野手を1人取得し、HitterQuizUi型を返す
  Future<HitterQuizUi> createHitterQuizUi(
    HitterSearchCondition searchCondition,
  );

  /// 登録されている全ての野手を取得する
  Future<List<HitterIdByName>> fetchAllHitter();
}
