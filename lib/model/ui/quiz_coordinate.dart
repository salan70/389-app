import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_coordinate.freezed.dart';

@freezed
// TODO このクラス不要説濃厚
class QuizCoordinate with _$QuizCoordinate {
  const factory QuizCoordinate({
    required int clmIdx,
    required int rowIdx,
  }) = _QuizCoordinate;
}
