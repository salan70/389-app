import 'package:model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_condition_notifier.g.dart';

@riverpod
class SearchConditionNotifier extends _$SearchConditionNotifier {
  @override
  SearchCondition build() =>
      ref.watch(searchConditionRepositoryProvider).fetchSearchCondition();
}
