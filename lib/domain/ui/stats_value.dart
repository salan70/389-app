import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_value.freezed.dart';

@freezed
class StatsValue with _$StatsValue {
  const factory StatsValue({
    required String id,
    required String data,
  }) = _StatsValue;
}
