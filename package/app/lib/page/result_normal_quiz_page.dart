import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../component/ad/banner_ad_widget.dart';
import '../component/quiz_result_common/custom_confetti_widget.dart';
import '../component/quiz_result_common/result_quiz_widget.dart';
import '../component/quiz_result_common/result_text.dart';
import '../component/quiz_result_common/share_button.dart';
import '../component/quiz_result_normal/replay_button.dart';
import '../controller/result_normal_quiz_page_controller.dart';
import '../core/common_widget/button/my_button.dart';
import '../core/common_widget/navigation_button/back_to_top_button.dart';

@RoutePage()
class ResultNormalQuizPage extends ConsumerWidget {
  ResultNormalQuizPage({super.key});

  static const _buttonWidth = 200.0;
  static const _shareText = '#プロ野球クイズ #389quiz\n$appStoreUrl';

  // Widget の画像を作成するために使用する。
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(resultNormalQuizPageControllerProvider);

    final hitterQuizProvider =
        hitterQuizNotifierProvider(QuizType.normal, questionedAt: null);

    // TODO(me): ここ listen する必要があるか確認する。（ initState でいいのでは？ ）
    ref.listen(
      hitterQuizProvider,
      (_, next) async {
        final nextHitterQuiz = next! as AsyncData<HitterQuiz>;
        await controller.onOpenPage(nextHitterQuiz);
      },
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ref.watch(hitterQuizProvider).maybeWhen(
                  orElse: Container.new,
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  data: (hitterQuiz) {
                    return Stack(
                      children: [
                        ListView(
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
                                child: ReplayButton(
                                  buttonType: ButtonType.main,
                                  onPressed: controller.onTapReplay,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: SizedBox(
                                width: _buttonWidth,
                                child: ShareButton(
                                  buttonType: ButtonType.sub,
                                  onPressed: () => controller.shareQuiz(
                                    _globalKey,
                                    _shareText,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Center(
                              child: SizedBox(
                                width: _buttonWidth,
                                child:
                                    BackToTopButton(buttonType: ButtonType.sub),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
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
      ),
    );
  }
}
