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

  factory ReviewHistory.fromJson(Map<String, dynamic> json) =>
      _$ReviewHistoryFromJson(json);
  const ReviewHistory._();

  /// レビューダイアログを表示後、次のレビューダイアログを表示するまでの最低日数。
  static const _minDayCount = 7;

  /// 最後にレビューダイアログを表示してから [_minDayCount] 日経過しているかどうか。
  bool get isReviewDialogPastMinDayCount {
    // レビューダイアログを表示したことがない場合は、true を返す。
    if (!isDisplayedReviewDialog) {
      return true;
    }

    final diff = DateTime.now().difference(updatedAt).inDays;
    return diff >= _minDayCount;
  }
}
