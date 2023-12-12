import 'package:baseball_quiz_app/feature/quiz_result/domain/hitter_quiz_result.dart';
import 'package:baseball_quiz_app/feature/quiz_result/presentation/gallery_detail/component/delete_normal_quiz_button.dart';
import 'package:baseball_quiz_app/util/constant/hitting_stats_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../util/constant/strings_constant.dart';
import '../../../../common_widget/back_button.dart' as common;
import '../../../../common_widget/my_button.dart';
import '../../../admob/presentation/banner_ad_widget.dart';
import '../../../quiz/domain/hitter_quiz.dart';
import '../../../quiz/presentation/component/result_quiz_widget.dart';
import '../../../quiz/presentation/component/share_button.dart';
import 'component/result_info_widget.dart';
import 'component/result_rank_label_widget.dart';
import 'component/show_answer_button.dart';

class NormalQuizGalleryDetailPage extends StatelessWidget {
  NormalQuizGalleryDetailPage({super.key, required this.quizResult});

  final HitterQuizResult quizResult;

  static const _shareText = '#プロ野球クイズ #389quiz\n$appStoreUrl';
  static const _buttonWidth = 160.0;
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
