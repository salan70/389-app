import 'package:baseball_quiz_app/ui/page/prepare_quiz/prepare_quiz_view_model.dart';
import 'package:baseball_quiz_app/util/constant/hitter_search_condition_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final viewModel = ProviderContainer().read(prepareQuizViewModelProvider);

  group('isValidChoseTeamList関数', () {
    test('最小値-1', () {
      final result = viewModel.isValidChoseTeamList(minChoseTeamNum - 1);
      expect(false, result);
    });

    test('最小値', () {
      final result = viewModel.isValidChoseTeamList(minChoseTeamNum);
      expect(true, result);
    });

    test('最小値+1', () {
      final result = viewModel.isValidChoseTeamList(minChoseTeamNum + 1);
      expect(true, result);
    });
  });

  group('canChangeState関数', () {
    test('選択可能上限数と同じ かつ すでに選択されている', () {
      final result = viewModel.canChangeState(
        selectedLength: mustSelectStatsNum,
        isSelected: true,
      );
      expect(true, result);
    });

    test('選択可能上限数と同じ かつ 選択されていない', () {
      final result = viewModel.canChangeState(
        selectedLength: mustSelectStatsNum,
        isSelected: false,
      );
      expect(false, result);
    });

    test('選択可能上限数未満', () {
      final result = viewModel.canChangeState(
        selectedLength: mustSelectStatsNum - 1,
        isSelected: false,
      );
      expect(true, result);
    });

    // 実際のアプリではこのケースにならない想定
    test('選択可能上限数より多い', () {
      final result = viewModel.canChangeState(
        selectedLength: mustSelectStatsNum + 1,
        isSelected: false,
      );
      expect(false, result);
    });
  });

  group('isValidSelectedStatsList関数', () {
    test('選択可能上限数と同じ', () {
      final result = viewModel.isValidSelectedStatsList(mustSelectStatsNum);
      expect(true, result);
    });

    test('選択可能上限数より多い', () {
      final result = viewModel.isValidSelectedStatsList(mustSelectStatsNum + 1);
      expect(false, result);
    });

    test('選択可能上限数より多い', () {
      final result = viewModel.isValidSelectedStatsList(mustSelectStatsNum - 1);
      expect(false, result);
    });
  });
}
