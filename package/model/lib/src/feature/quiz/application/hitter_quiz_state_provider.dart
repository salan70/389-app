import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../search_condition/application/search_condition_state.dart';
import '../domain/hitter_quiz_state.dart';
import '../infrastructure/hitter_repository.dart';

part 'hitter_quiz_state_provider.g.dart';

/// 保存されている検索条件をもとに [HitterQuizState] を取得する。
///
/// 検索条件に合う [HitterQuizState] が存在しない場合は、 `null` を返す。
@riverpod
Future<HitterQuizState> hitterQuizState(HitterQuizStateRef ref) async {
  final searchCondition = ref.watch(searchConditionProvider);
  return ref
      .watch(hitterRepositoryProvider)
      .fetchHitterQuizBySearchCondition(searchCondition);
}
