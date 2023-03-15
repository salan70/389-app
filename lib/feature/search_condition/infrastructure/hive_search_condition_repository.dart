import 'package:hive_flutter/hive_flutter.dart';

import '../constant/search_condition_constant.dart';
import '../domain/search_condition.dart';
import '../domain/search_condition_repository.dart';

class HiveSearchConditionRepository implements SearchConditionRepository {
  HiveSearchConditionRepository(
    this.box,
  );

  final Box<SearchCondition> box;

  @override
  SearchCondition fetchSearchCondition() {
    final searchCondition = box.get(
      searchConditionBoxKey,
      defaultValue: defaultSearchCondition,
    )!;

    // selectedStatsListに年度が含まれている場合は削除して、返す
    return searchCondition.copyWith(
      selectedStatsList: List<String>.from(
        searchCondition.selectedStatsList,
      )..remove('年度'),
    );
  }

  @override
  void saveSearchCondition(SearchCondition searchCondition) {
    box.put(searchConditionBoxKey, searchCondition);
  }
}
