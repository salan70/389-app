import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../search_condition/application/search_condition_state.dart';
import '../domain/hitter_quiz_state.dart';
import '../infrastructure/hitter_repository.dart';

part 'hitter_quiz_state_provider.g.dart';

/// 保存されている検索条件をもとに [InputQuizState] を取得する。
///
/// 検索条件に合う選手が存在しない場合は、 `null` を返す。
@riverpod
Future<InputQuizState> normalQuizState(NormalQuizStateRef ref) async {
  final searchCondition = ref.watch(searchConditionProvider);
  return ref
      .watch(hitterRepositoryProvider)
      .fetchNormalHitterQuizState(searchCondition);
}
