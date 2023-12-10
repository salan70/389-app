import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/json_converter.dart';

part 'review_history.freezed.dart';
part 'review_history.g.dart';

@freezed
class ReviewHistory with _$ReviewHistory {
  const factory ReviewHistory({
    required bool isDisplayedReviewDialog,
    @DateTimeConverter() required DateTime updatedAt,
  }) = _ReviewHistory;

  const ReviewHistory._();

  factory ReviewHistory.fromJson(Map<String, dynamic> json) =>
      _$ReviewHistoryFromJson(json);
}
