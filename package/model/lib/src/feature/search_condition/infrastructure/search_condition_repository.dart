import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../util/enum/hive_box_type.dart';
import '../domain/search_condition.dart';
import '../util/search_condition_constant.dart';

part 'search_condition_repository.g.dart';

/// [SearchConditionRepository] の Provider.
@riverpod
SearchConditionRepository searchConditionRepository(
  SearchConditionRepositoryRef ref,
) =>
    throw UnimplementedError();

class SearchConditionRepository {
  SearchConditionRepository(this.box);

  final Box<SearchCondition> box;

  final _boxKey = HiveBoxType.searchCondition.key;

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

  void saveSearchCondition(SearchCondition searchCondition) {
    box.put(_boxKey, searchCondition);
  }
}
