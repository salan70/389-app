import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../component/ad/banner_ad_widget.dart';
import '../component/gallery/delete_normal_quiz_button.dart';
import '../component/history/result_info_widget.dart';
import '../component/history/result_rank_label_widget.dart';
import '../component/history/show_answer_button.dart';
import '../component/quiz_result/result_quiz_widget.dart';
import '../component/quiz_result/share_button.dart';
import '../controller/quiz_history_daily_page_controller.dart';
import '../core/common_widget/button/my_button.dart';
import '../core/common_widget/navigation_button/back_button.dart' as common;

@RoutePage()
class QuizHistoryNormalPage extends ConsumerWidget {
  QuizHistoryNormalPage({super.key, required this.quizResult});

  final HitterQuizResult quizResult;

  static const _shareText = '#プロ野球クイズ #389quiz\n$appStoreUrl';
  static const _buttonWidth = 160.0;
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: ListView(
            children: [
              const BannerAdWidget(),
              const SizedBox(height: 16),
              ResultRankLabelWidget(quizResult: quizResult),
              const SizedBox(height: 16),
              ResultQuizWidget(
                globalKey: _globalKey,
                hitterQuiz: HitterQuiz.fromHitterResult(
                  quizResult,
                  QuizType.normal,
                ),
              ),
              const SizedBox(height: 8),
              ResultInfoWidget(quizResult: quizResult),
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: _buttonWidth,
                  child: ShowAnswerButton(
                    buttonType: ButtonType.main,
                    quizResult: quizResult,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: SizedBox(
                  width: _buttonWidth,
                  child: ShareButton(
                    buttonType: ButtonType.sub,
                    // TODO(me): 仮に他 Page の Controller を使っているので、修正する。
                    onPressed: () => ref
                        .read(quizHistoryDailyPageControllerProvider)
                        .shareQuiz(_globalKey, _shareText),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Center(
                child: SizedBox(
                  width: _buttonWidth,
                  child: common.BackButton(buttonType: ButtonType.sub),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: _buttonWidth,
                  child: DeleteNormalQuizResultButton(
                    quizResult: quizResult,
                    onDeleteComplete: context.popRoute,
                  ),
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
