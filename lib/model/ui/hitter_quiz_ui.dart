import 'package:baseball_quiz_app/model/hitting_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
