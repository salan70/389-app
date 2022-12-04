import 'package:freezed_annotation/freezed_annotation.dart';

import '../hitting_stats.dart';

part 'hitter_quiz_ui.freezed.dart';

@freezed
class HitterQuizUi with _$HitterQuizUi {
  const factory HitterQuizUi({
    required String id,
    required String name,
    required String team,
    required List<HittingStats> hittingStatsList,
  }) = _HitterQuizUi;
}
