import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/hitter_search_condition.dart';

final hitterSearchConditionRepositoryProvider =
    Provider<HitterSearchConditionRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class HitterSearchConditionRepository {
  HitterSearchCondition fetchHitterSearchCondition();

  void saveHitterSearchCondition(HitterSearchCondition hitterSearchCondition);
}
