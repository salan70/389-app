import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:model/model.dart';

import '../core/common_widget/button/back_button.dart' as common;
import '../core/common_widget/button/my_button.dart';
import '../feature/ad/banner_ad_widget.dart';
import '../feature/gallery/delete_normal_quiz_button.dart';
import '../feature/gallery/result_info_widget.dart';
import '../feature/gallery/result_rank_label_widget.dart';
import '../feature/gallery/show_answer_button.dart';
import '../feature/quiz_result/result_quiz_widget.dart';
import '../feature/quiz_result/share_button.dart';

@RoutePage()
class NormalQuizGalleryDetailPage extends StatelessWidget {
  NormalQuizGalleryDetailPage({super.key, required this.quizResult});

  final HitterQuizResult quizResult;

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
              Center(
                child: SizedBox(
                  width: _buttonWidth,
                  child: DeleteNormalQuizResultButton(
                    quizResult: quizResult,
                    onDeleteComplete: Navigator.of(context).pop,
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
