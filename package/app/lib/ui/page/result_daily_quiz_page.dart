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
                        ResultText(hitterQuiz: hitterQuiz),
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
                              // TODO(me): 仮に他 Page の Controller を使っているので、修正する。
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
