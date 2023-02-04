import 'package:baseball_quiz_app/repository/supabase/supabase_hitter_converter.dart';
import 'package:baseball_quiz_app/util/constant/hitting_stats/probability_stats.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_hitter.dart';

void main() async {
  final converter = SupabaseHitterConverter();

  group('toHitterQuizUi', () {
    test('正常系', () {
      final result = converter.toHitterQuizUi(
        dummyHitter,
        dummyHittingStatsList,
        dummyHitterSearchCondition.selectedStatsList,
      );
      expect(dummyHitterQuizUi.id, result.id);
      expect(dummyHitterQuizUi.name, result.name);
      expect(dummyHitterQuizUi.selectedStatsList, result.selectedStatsList);

      // idがランダムに振られるため、完全に一致させることができない
      // そのため、lengthを比べている
      expect(dummyHitterQuizUi.statsMapList.length, result.statsMapList.length);
      expect(
        dummyHitterQuizUi.hiddenStatsIdList.length,
        result.hiddenStatsIdList.length,
      );
    });
  });

  group('toStatsMap', () {
    test('正常系', () {
      final statsMap = converter.toStatsMap(
        dummyHittingStats.stats,
        dummyHitterSearchCondition.selectedStatsList,
      );
      final resultKeys = statsMap.keys.toList();

      final deepEquals = const DeepCollectionEquality.unordered().equals;
      final result =
          deepEquals(resultKeys, dummyHitterSearchCondition.selectedStatsList);

      // selectedStatsListに入っているものと一致する成績を格納しているか確認（順不同）
      expect(
        true,
        result,
      );
    });
  });

  group('formatStatsValue', () {
    test('keyの値がprobabilityStatsに入っている場合', () {
      const key = '打率';
      const value = '.333';
      final result = converter.formatStatsValue(
        key,
        value,
      );

      expect(true, probabilityStats.contains(key));
      expect(
        value,
        result.data,
      );
      // idはランダム生成されるため、型だけの確認
      expect(
        String,
        result.id.runtimeType,
      );
    });

    test('keyの値がprobabilityStatsに入っていない場合', () {
      const key = '球団';
      const value = 'DeNA';
      final result = converter.formatStatsValue(
        key,
        value,
      );

      expect(false, probabilityStats.contains(key));
      expect(
        value,
        result.data,
      );
      // idはランダム生成されるため、型だけの確認
      expect(
        String,
        result.id.runtimeType,
      );
    });
  });

  group('formatStatsData', () {
    test('double型に変換できない場合 1', () {
      const data = '.---';
      final result = converter.formatStatsData(
        data,
      );
      expect(data, result);
    });

    test('double型に変換できない場合 2', () {
      const data = '---';
      final result = converter.formatStatsData(
        data,
      );
      expect(data, result);
    });

    test('double型に変換できない場合 3', () {
      const data = '.300';
      final result = converter.formatStatsData(
        data,
      );
      expect(data, result);
    });

    test('1.0未満の場合 1', () {
      const data = '0.300';
      final result = converter.formatStatsData(
        data,
      );
      expect('.300', result);
    });

    test('1.0未満の場合 2', () {
      const data = '0.999';
      final result = converter.formatStatsData(
        data,
      );
      expect('.999', result);
    });

    test('1.0未満の場合 3', () {
      const data = '0.000';
      final result = converter.formatStatsData(
        data,
      );
      expect('.000', result);
    });

    test('1.0以上の場合 1', () {
      const data = '1.000';
      final result = converter.formatStatsData(
        data,
      );
      expect('1.000', result);
    });
  });
}
