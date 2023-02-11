import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/base_repository/hitter_search_condition_repository.dart';
import '../../domain/typeadapter/hitter_search_condition.dart';
import '../../util/constant/hitter_search_condition_constant.dart';

class HiveHitterSearchConditionRepository
    implements HitterSearchConditionRepository {
  HiveHitterSearchConditionRepository(
    this.box,
  );

  final Box<HitterSearchCondition> box;

  @override
  HitterSearchCondition fetchHitterSearchCondition() {
    return box.get(
      hitterSearchConditionBoxKey,
      defaultValue: defaultHittingSearchCondition,
    )!;
  }

  @override
  void saveHitterSearchCondition(HitterSearchCondition hitterSearchCondition) {
    box.put(hitterSearchConditionBoxKey, hitterSearchCondition);
  }
}
