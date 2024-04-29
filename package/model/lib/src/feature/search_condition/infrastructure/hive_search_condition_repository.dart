import 'package:hive_flutter/hive_flutter.dart';

import '../../../util/enum/hive_box_type.dart';
import '../domain/search_condition.dart';
import '../domain/search_condition_repository.dart';
import '../util/search_condition_constant.dart';

class HiveSearchConditionRepository implements SearchConditionRepository {
  HiveSearchConditionRepository(
    this.box,
  );

  final Box<SearchCondition> box;

  final _boxKey = HiveBoxType.searchCondition.key;

  @override
  SearchCondition fetchSearchCondition() {
    final searchCondition = box.get(
      _boxKey,
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
    box.put(_boxKey, searchCondition);
  }
}
