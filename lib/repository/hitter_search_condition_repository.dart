import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/typeadapter/hitter_search_condition.dart';

final hitterSearchConditionRepositoryProvider =
    Provider<HitterSearchConditionRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

abstract class HitterSearchConditionRepository {
  HitterSearchCondition fetchHitterSearchCondition();

  void saveHitterSearchCondition(HitterSearchCondition hitterSearchCondition);
}
