import 'package:flutter/material.dart';

import '../../../../util/constant/strings_constant.dart';
import '../../../feature/quiz/domain/hitter_quiz.dart';
import '../../../feature/quiz_result/domain/hitter_quiz_result.dart';
import '../../../util/enum/quiz_type.dart';
import '../../common_widget/back_button.dart' as common;
import '../../common_widget/banner_ad_widget.dart';
import '../../common_widget/gallery_detail/result_info_widget.dart';
import '../../common_widget/gallery_detail/result_rank_label_widget.dart';
import '../../common_widget/gallery_detail/show_answer_button.dart';
import '../../common_widget/my_button.dart';
import '../../common_widget/quiz_result/result_quiz_widget.dart';
import '../../common_widget/quiz_result/share_button.dart';

class DailyQuizGalleryDetailPage extends StatelessWidget {
  DailyQuizGalleryDetailPage({super.key, required this.hitterQuizResult});

  final HitterQuizResult hitterQuizResult;

  static const _shareText = '#プロ野球クイズ #389quiz\n$appStoreUrl';
  static const _buttonWidth = 160.0;
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: ListView(
            children: [
              const BannerAdWidget(),
              const SizedBox(height: 16),
              ResultRankLabelWidget(quizResult: hitterQuizResult),
              const SizedBox(height: 16),
              ResultQuizWidget(
                globalKey: _globalKey,
                hitterQuiz: HitterQuiz.fromHitterResult(
                  hitterQuizResult,
                  QuizType.daily,
                ),
              ),
              const SizedBox(height: 8),
              ResultInfoWidget(quizResult: hitterQuizResult),
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: _buttonWidth,
                  child: ShowAnswerButton(
                    buttonType: ButtonType.main,
                    quizResult: hitterQuizResult,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: SizedBox(
                  width: _buttonWidth,
                  child: ShareButton(
                    buttonType: ButtonType.sub,
                    globalKey: _globalKey,
                    shareText: _shareText,
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
            ],
          ),
        ),
      ),
    );
  }
}
