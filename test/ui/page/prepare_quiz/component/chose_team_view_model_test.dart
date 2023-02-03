import 'package:baseball_quiz_app/ui/page/prepare_quiz/component/chose_team_view_model.dart';
import 'package:baseball_quiz_app/util/constant/hitter_search_condition_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidChoseTeamList', () {
    test('最小値-1', () {
      final result = ProviderContainer()
          .read(choseTeamViewModelProvider)
          .isValidChoseTeamList(minChoseTeamNum - 1);

      expect(false, result);
    });

    test('最小値', () {
      final result = ProviderContainer()
          .read(choseTeamViewModelProvider)
          .isValidChoseTeamList(minChoseTeamNum);

      expect(true, result);
    });

    test('最小値+1', () {
      final result = ProviderContainer()
          .read(choseTeamViewModelProvider)
          .isValidChoseTeamList(minChoseTeamNum + 1);

      expect(true, result);
    });
  });
}
