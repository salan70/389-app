import 'package:baseball_quiz_app/constant/hitter_search_condition_constant.dart';
import 'package:baseball_quiz_app/ui/page/prepare_quiz/component/select_stats_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('canChangeState', () {
    test('選択可能上限数と同じ かつ すでに選択されている', () {
      final result = ProviderContainer()
          .read(selectStatsViewModelProvider)
          .canChangeState(selectedLength: mustSelectStatsNum, isSelected: true);

      expect(true, result);
    });

    test('選択可能上限数と同じ かつ 選択されていない', () {
      final result =
          ProviderContainer().read(selectStatsViewModelProvider).canChangeState(
                selectedLength: mustSelectStatsNum,
                isSelected: false,
              );

      expect(false, result);
    });

    test('選択可能上限数未満', () {
      final result =
          ProviderContainer().read(selectStatsViewModelProvider).canChangeState(
                selectedLength: mustSelectStatsNum - 1,
                isSelected: false,
              );

      expect(true, result);
    });

    // 実際のアプリではこのケースにならない想定
    test('選択可能上限数より多い', () {
      final result =
          ProviderContainer().read(selectStatsViewModelProvider).canChangeState(
                selectedLength: mustSelectStatsNum + 1,
                isSelected: false,
              );

      expect(false, result);
    });
  });

  group('isValidSelectedStatsList', () {
    test('選択可能上限数と同じ', () {
      final result = ProviderContainer()
          .read(selectStatsViewModelProvider)
          .isValidSelectedStatsList(
            mustSelectStatsNum,
          );
      expect(true, result);
    });

    test('選択可能上限数より多い', () {
      final result = ProviderContainer()
          .read(selectStatsViewModelProvider)
          .isValidSelectedStatsList(
            mustSelectStatsNum + 1,
          );
      expect(false, result);
    });

    test('選択可能上限数より多い', () {
      final result = ProviderContainer()
          .read(selectStatsViewModelProvider)
          .isValidSelectedStatsList(
            mustSelectStatsNum - 1,
          );
      expect(false, result);
    });
  });
}
