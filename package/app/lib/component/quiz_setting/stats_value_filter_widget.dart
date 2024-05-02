import 'package:flutter/material.dart';
import 'package:model/model.dart';

class StatsValueFilterWidget extends StatelessWidget {
  const StatsValueFilterWidget({
    super.key,
    required this.searchCondition,
    required this.updateMinGames,
    required this.updateMinHits,
    required this.updateMinHr,
  });

  final SearchCondition searchCondition;

  /// 検索条件である「最低出場数」更新時の処理。
  final void Function(int?) updateMinGames;

  /// 検索条件である「最低ヒット数」更新時の処理。
  final void Function(int?) updateMinHits;

  /// 検索条件である「最低ホームラン数」更新時の処理。
  final void Function(int?) updateMinHr;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left: 16, right: size.width * 0.2),
      child: Column(
        children: [
          // 最低通算試合数
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('最低通算試合数'),
              DropdownButton<int>(
                items: _statsFilterDropdownMenu(minGamesOptionList),
                onChanged: updateMinGames,
                value: searchCondition.minGames,
              ),
            ],
          ),
          // 最低通算打席数
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('最低通算ヒット数'),
              DropdownButton<int>(
                items: _statsFilterDropdownMenu(minHitsOptionList),
                onChanged: updateMinHits,
                value: searchCondition.minHits,
              ),
            ],
          ),
          // 最低通算ホームラン数
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('最低通算ホームラン数'),
              DropdownButton<int>(
                items: _statsFilterDropdownMenu(minHrOptionList),
                onChanged: updateMinHr,
                value: searchCondition.minHr,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _statsFilterDropdownMenu(List<int> intItemList) {
    return intItemList
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text('$e'),
          ),
        )
        .toList();
  }
}
