import 'package:baseball_quiz_app/constant/stats_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hitter_quiz_ui.freezed.dart';

@freezed
class HitterQuizUi with _$HitterQuizUi {
  const factory HitterQuizUi({
    required String id,
    required String name,
    required List<StatsType> statsLabels,
    required List<Map<String, String>> statsList,
  }) = _HitterQuizUi;
}
