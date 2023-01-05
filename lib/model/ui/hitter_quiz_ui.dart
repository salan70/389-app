import 'package:freezed_annotation/freezed_annotation.dart';

import 'stats_value.dart';

part 'hitter_quiz_ui.freezed.dart';

@freezed
class HitterQuizUi with _$HitterQuizUi {
  const factory HitterQuizUi({
    required String id,
    required String name,
    required List<String> selectedStatsList,
    required List<Map<String, StatsValue>> statsMapList,
    required List<String> closedStatsIdList,
  }) = _HitterQuizUi;
}
