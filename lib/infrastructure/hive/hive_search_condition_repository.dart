import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entity/search_condition.dart';
import '../../domain/repository/search_condition_repository.dart';
import '../../util/constant/search_condition_constant.dart';

class HiveSearchConditionRepository implements SearchConditionRepository {
  HiveSearchConditionRepository(
    this.box,
  );

  final Box<SearchCondition> box;

  @override
  SearchCondition fetchSearchCondition() {
    return box.get(
      searchConditionBoxKey,
      defaultValue: defaultSearchCondition,
    )!;
  }

  @override
  void saveSearchCondition(SearchCondition searchCondition) {
    box.put(searchConditionBoxKey, searchCondition);
  }
}
