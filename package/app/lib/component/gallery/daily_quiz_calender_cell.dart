import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../core/util/extension/result_rank_extension.dart';

class DailyQuizCalenderCell extends ConsumerWidget {
  const DailyQuizCalenderCell({
    super.key,
    required this.dailyHitterQuizResult,
    required this.date,
    required this.onTapPlayedDailyQuiz,
    required this.onTapNotPlayedDailyQuiz,
  });

  /// [DailyQuiz] のプレイ結果をすべて保持するオブジェクト。
  final DailyHitterQuizResult dailyHitterQuizResult;

  /// 対象となる [DailyQuiz] の出題日。
  final DateTime date;

  /// プレイ済みの [DailyQuiz] のセルをタップした際の処理。
  final VoidCallback onTapPlayedDailyQuiz;

  /// 未プレイかつ出題済みの [DailyQuiz] のセルをタップした際の処理。
  final VoidCallback onTapNotPlayedDailyQuiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyQuizStatus =
        DailyQuizCellType.getQuizStatus(dailyHitterQuizResult, date);

    switch (dailyQuizStatus) {
      case DailyQuizCellType.played:
        final formattedDate = date.toFormattedString();
        final hitterQuizResult =
            dailyHitterQuizResult.resultMap[formattedDate]!;

        return InkWell(
          onTap: onTapPlayedDailyQuiz,
          child: Center(
            child: FittedBox(
              child: hitterQuizResult.resultRank.smallLabelWidget,
            ),
          ),
        );

      case DailyQuizCellType.notPlayed:
        return InkWell(
          onTap: onTapNotPlayedDailyQuiz,
          child: const Center(child: Text('-')),
        );

      case DailyQuizCellType.future:
        return const SizedBox.shrink();
    }
  }
}

enum DailyQuizCellType {
  /// プレイ済み。
  played,

  /// 未プレイ。（過去に出題済み）
  notPlayed,

  /// 未来の日付。
  future;

  /// 状況に応じた [DailyQuizCellType] を返す。
  static DailyQuizCellType getQuizStatus(
    DailyHitterQuizResult dailyHitterQuizResult,
    DateTime date,
  ) {
    // * プレイ済みの日付。
    final formattedDate = date.toFormattedString();
    if (dailyHitterQuizResult.resultMap.containsKey(formattedDate)) {
      return DailyQuizCellType.played;
    }

    // * 未プレイ かつ 過去の日付。
    final nowInApp = DateTime.now().calculateDateInApp();
    if (date.isBefore(nowInApp)) {
      return DailyQuizCellType.notPlayed;
    }

    // * 未来の日付。
    return DailyQuizCellType.future;
  }
}
