import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../component/ad/banner_ad_widget.dart';
import '../component/common/button/my_button.dart';
import '../component/common/navigation_button/back_to_top_button.dart';
import '../component/quiz_result_common/custom_confetti_widget.dart';
import '../component/quiz_result_common/result_quiz_widget.dart';
import '../component/quiz_result_common/result_text.dart';
import '../component/quiz_result_common/share_button.dart';
import '../controller/result_daily_quiz_page_controller.dart';

@RoutePage()
class ResultDailyQuizPage extends ConsumerWidget {
  ResultDailyQuizPage({super.key, required this.quizState});

  final InputQuizState quizState;

  static const _shareText = '#プロ野球クイズ #389quiz #今日の1問\n$appStoreUrl';
  static const _buttonWidth = 160.0;
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ListView(
                  children: [
                    const BannerAdWidget(),
                    const SizedBox(height: 16),
                    ResultText(quizState: quizState),
                    ResultQuizWidget(
                      globalKey: _globalKey,
                      hitterQuiz: quizState.hitterQuiz,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: SizedBox(
                        width: _buttonWidth,
                        child: ShareButton(
                          buttonType: ButtonType.sub,
                          onPressed: () => ref
                              .read(resultDailyQuizPageControllerProvider)
                              .shareQuiz(_globalKey, _shareText),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: SizedBox(
                        width: _buttonWidth,
                        child: BackToTopButton(buttonType: ButtonType.main),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomConfettiWidget(
                  isCorrect: quizState.isCorrectEnteredHitter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
