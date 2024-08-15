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
import '../component/quiz_result_normal/replay_button.dart';
import '../controller/result_normal_quiz_page_controller.dart';

@RoutePage()
class ResultNormalQuizPage extends ConsumerStatefulWidget {
  const ResultNormalQuizPage({super.key, required this.quizState});

  final HitterQuizState quizState;

  @override
  ConsumerState<ResultNormalQuizPage> createState() =>
      _ResultNormalQuizPageState();
}

class _ResultNormalQuizPageState extends ConsumerState<ResultNormalQuizPage> {
  static const _buttonWidth = 200.0;
  static const _shareText = '#プロ野球クイズ #389quiz\n$appStoreUrl';

  // Widget の画像を作成するために使用する。
  final _globalKey = GlobalKey();

  // TODO(me): initState からの呼び出しで問題ないか動作確認する。
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(resultNormalQuizPageControllerProvider)
            .onOpenPage(widget.quizState);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(resultNormalQuizPageControllerProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Stack(
              children: [
                ListView(
                  children: [
                    const BannerAdWidget(),
                    const SizedBox(height: 16),
                    ResultText(quizState: widget.quizState),
                    ResultQuizWidget(
                      globalKey: _globalKey,
                      hitterQuiz: widget.quizState.hitterQuiz,
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
                          onPressed: () =>
                              controller.shareQuiz(_globalKey, _shareText),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: SizedBox(
                        width: _buttonWidth,
                        child: BackToTopButton(buttonType: ButtonType.sub),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                Positioned(
                  bottom: 24,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CustomConfettiWidget(
                      isCorrect: widget.quizState.isCorrectEnteredHitter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
