import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/ad/banner_ad_widget.dart';
import '../component/quiz_setting/chose_team_widget.dart';
import '../component/quiz_setting/notes_text.dart';
import '../component/quiz_setting/select_stats_widget.dart';
import '../component/quiz_setting/stats_value_filter_widget.dart';
import '../component/quiz_setting/to_play_normal_quiz_from_prepare_button.dart';
import '../controller/quiz_setting_page_controller.dart';
import '../core/common_widget/button/my_button.dart';
import '../core/common_widget/navigation_button/back_to_top_button.dart';

@RoutePage()
class QuizSettingPage extends ConsumerWidget {
  const QuizSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCondition =
        ref.watch(quizSettingPageControllerProvider).searchCondition;
    final controller = ref.watch(quizSettingPageControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              const BannerAdWidget(),
              const SizedBox(height: 16),
              ChoseTeamWidget(
                teamList: searchCondition.teamList,
                onChange: controller.updateTeamList,
                isValidTeamList: controller.isValidTeamList,
                chipOnDelete: controller.chipOnDelete,
              ),
              const SizedBox(height: 16),
              StatsValueFilterWidget(
                searchCondition: searchCondition,
                updateMinGames: (int? value) =>
                    controller.updateMinGames(value!),
                updateMinHits: (int? value) => controller.updateMinHits(value!),
                updateMinHr: (int? value) => controller.updateMinHr(value!),
              ),
              const SizedBox(height: 16),
              SelectStatsWidget(
                selectedStatsList: searchCondition.selectedStatsList,
                onChange: controller.updateSelectedStatsList,
                isValidSelectedStatsList: controller.isValidSelectedStatsList,
                canChangeStatsState: controller.canChangeStatsState,
              ),
              const SizedBox(height: 16),
              const NotesText(),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: 160,
                  child: ToPlayNormalQuizFromPrepareButton(
                    buttonType: ButtonType.main,
                    onTapPlayNormalQuiz: controller.onTapPlayNormalQuiz,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: SizedBox(
                  width: 160,
                  child: BackToTopButton(buttonType: ButtonType.sub),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
