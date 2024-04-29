import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:model/src/feature/quiz/infrastructure/hitter_converter.dart';
import 'package:model/src/util/enum/hitting_stats_type.dart';
import 'package:model/src/util/enum/quiz_type.dart';

import '../../../../dummy_data/dummy_hitter.dart';

void main() async {
  final converter = HitterConverter();

  group('toHitterQuiz関数', () {
    test('正常系', () {
      final result = converter.toHitterQuiz(
        QuizType.normal,
        dummyHitter,
        dummyHittingStatsList,
        dummySearchCondition.selectedStatsList,
      );
      expect(dummyHitterQuiz.id, result.id);
      expect(dummyHitterQuiz.name, result.name);
      expect(dummyHitterQuiz.yearList, result.yearList);
      expect(dummyHitterQuiz.selectedStatsList, result.selectedStatsList);
      expect(dummyHitterQuiz.statsMapList.length, result.statsMapList.length);
      expect(dummyHitterQuiz.unveilCount, result.unveilCount);
    });
  });

  group('toStatsMap関数', () {
    test('正常系', () {
      final statsMap = converter.toStatsMap(
        dummyHittingStats.stats,
        dummySearchCondition.selectedStatsList,
      );
      final resultKeys = statsMap.keys.toList();

      final deepEquals = const DeepCollectionEquality.unordered().equals;
      final result =
          deepEquals(resultKeys, dummySearchCondition.selectedStatsList);

      // selectedStatsListに入っているものと一致する成績を格納しているか確認（順不同）
      expect(
        true,
        result,
      );
    });
  });

  group('formatStatsValue関数', () {
    test('keyの値がprobabilityStatsに入っている場合', () {
      const key = '打率';
      const value = '.333';
      final result = converter.formatStatsValue(
        key,
        value,
      );

      expect(true, probabilityStats.contains(key));
      expect(value, result);
    });

    test('keyの値がprobabilityStatsに入っていない場合', () {
      const key = '球団';
      const value = 'DeNA';
      final result = converter.formatStatsValue(
        key,
        value,
      );

      expect(false, probabilityStats.contains(key));
      expect(value, result);
    });
  });

  group('formatStatsData関数', () {
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
