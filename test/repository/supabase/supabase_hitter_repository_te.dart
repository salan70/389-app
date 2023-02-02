import 'package:baseball_quiz_app/constant/hitting_stats/probability_stats.dart';
import 'package:baseball_quiz_app/repository/supabase/supabase_hitter_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../dummy_data/dummy_hitter.dart';

// TODO(me): GitHub Actionsで実行できるようにする
/// GitHub Actionsで実行するとエラーになるため、
/// flutter testで実行されないよう、ファイル名の末尾をtestじゃなくしている。
void main() async {
  late SupabaseHitterRepository repository;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    const channel = MethodChannel('plugins.flutter.io/path_provider_macos');
    channel.setMockMethodCallHandler((methodCall) async {
      return '.';
    });

    await dotenv.load();
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_API_KEY']!,
    );
    repository = SupabaseHitterRepository(Supabase.instance);
  });

  group('toHitterQuizUi', () {
    test('正常系', () {
      final result = repository.toHitterQuizUi(
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
      final statsMap = repository.toStatsMap(
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
      final result = repository.formatStatsValue(
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
      final result = repository.formatStatsValue(
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
      final result = repository.formatStatsData(
        data,
      );
      expect(data, result);
    });

    test('double型に変換できない場合 2', () {
      const data = '---';
      final result = repository.formatStatsData(
        data,
      );
      expect(data, result);
    });

    test('double型に変換できない場合 3', () {
      const data = '.300';
      final result = repository.formatStatsData(
        data,
      );
      expect(data, result);
    });

    test('1.0未満の場合 1', () {
      const data = '0.300';
      final result = repository.formatStatsData(
        data,
      );
      expect('.300', result);
    });

    test('1.0未満の場合 2', () {
      const data = '0.999';
      final result = repository.formatStatsData(
        data,
      );
      expect('.999', result);
    });

    test('1.0未満の場合 3', () {
      const data = '0.000';
      final result = repository.formatStatsData(
        data,
      );
      expect('.000', result);
    });

    test('1.0以上の場合 1', () {
      const data = '1.000';
      final result = repository.formatStatsData(
        data,
      );
      expect('1.000', result);
    });
  });
}
