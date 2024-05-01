import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../component/ad/banner_ad_widget.dart';
import '../component/quiz_result/custom_confetti_widget.dart';
import '../component/quiz_result/result_quiz_widget.dart';
import '../component/quiz_result/result_text.dart';
import '../component/quiz_result/share_button.dart';
import '../core/common_widget/button/my_button.dart';
import '../core/common_widget/navigation_button/back_to_top_button.dart';

@RoutePage()
class ResultDailyQuizPage extends ConsumerWidget {
  ResultDailyQuizPage({super.key, required this.questionedAt});

  final DateTime questionedAt;

  static const _shareText = '#プロ野球クイズ #389quiz #今日の1問\n$appStoreUrl';
  static const _buttonWidth = 160.0;
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHitterQuiz = ref.watch(
      hitterQuizNotifierProvider(
        QuizType.daily,
        questionedAt: questionedAt,
      ),
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          // ignore: avoid_dynamic_calls
          child: asyncHitterQuiz.maybeWhen(
            orElse: Container.new,
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (hitterQuiz) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView(
                      children: [
                        const BannerAdWidget(),
                        const SizedBox(height: 16),
                        ResultText.daily(hitterQuiz: hitterQuiz),
                        ResultQuizWidget(
                          globalKey: _globalKey,
                          hitterQuiz: hitterQuiz,
                        ),
                        const SizedBox(height: 24),
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
                      isCorrect: hitterQuiz.isCorrect,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
