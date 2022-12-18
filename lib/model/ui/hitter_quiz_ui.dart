import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constant/hitting_stats/stats_type.dart';
import 'stats_value.dart';

part 'hitter_quiz_ui.freezed.dart';

@freezed
class HitterQuizUi with _$HitterQuizUi {
  const factory HitterQuizUi({
    required String id,
    required String name,
    required List<StatsType> selectedStatsTypeList,
    required List<Map<String, StatsValue>> statsList,
  }) = _HitterQuizUi;
}
