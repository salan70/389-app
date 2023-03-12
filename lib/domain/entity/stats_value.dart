import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_value.freezed.dart';
part 'stats_value.g.dart';

/// 成績の値と表示順を表すクラス
///
/// unveilOrder : 表示順,
/// data : 成績（データ）
@freezed
class StatsValue with _$StatsValue {
  const factory StatsValue({
    required int unveilOrder,
    required String data,
  }) = _StatsValue;

  factory StatsValue.fromJson(Map<String, dynamic> json) =>
      _$StatsValueFromJson(json);
}
