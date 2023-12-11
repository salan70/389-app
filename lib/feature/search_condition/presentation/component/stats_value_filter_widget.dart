import 'package:baseball_quiz_app/feature/search_condition/application/search_condition_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/search_condition_constant.dart';

class StatsValueFilterWidget extends ConsumerWidget {
  const StatsValueFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition = ref.watch(searchConditionNotifierProvider);
    final notifier = ref.watch(searchConditionNotifierProvider.notifier);

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
                onChanged: (int? value) => notifier.updateMinGames(value!),
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
                onChanged: (int? value) => notifier.updateMinHits(value!),
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
                onChanged: (int? value) => notifier.updateMinHr(value!),
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
