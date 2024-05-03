import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../component/ad/banner_ad_widget.dart';
import '../component/play_quiz_common/input_answer_text_field.dart';
import '../component/play_quiz_common/quiz_event_buttons.dart';
import '../component/play_quiz_common/quiz_widget.dart';
import '../component/play_quiz_common/retire_button.dart';
import '../component/play_quiz_common/submit_answer_button.dart';
import '../controller/play_normal_quiz_page_controller.dart';
import '../core/common_widget/button/my_button.dart';

@RoutePage()
class PlayNormalQuizPage extends ConsumerStatefulWidget {
  PlayNormalQuizPage({super.key});

  final _textEditingController = TextEditingController();
  final _buttonWidth = 160.0;

  @override
  ConsumerState<PlayNormalQuizPage> createState() => _PlayNormalQuizPageState();
}

class _PlayNormalQuizPageState extends ConsumerState<PlayNormalQuizPage> {
  @override
  void dispose() {
    widget._textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncHitterQuiz = ref
        .watch(hitterQuizNotifierProvider(QuizType.normal, questionedAt: null));

    final controller = ref.watch(playNormalQuizPageControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: asyncHitterQuiz.maybeWhen(
              orElse: Container.new,
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (hitterQuiz) {
                return ListView(
                  children: [
                    const BannerAdWidget(),
                    const SizedBox(height: 16),
                    QuizWidget(hitterQuiz: hitterQuiz),
                    const SizedBox(height: 16),
                    InputAnswerTextField(
                      textEditingController: widget._textEditingController,
                      onSearchHitter: () => controller
                          .onSearchHitter(widget._textEditingController.text),
                      onSelectedHitter: (Hitter value) {},
                    ),
                    const SizedBox(height: 16),
                    QuizEventButtons(
                      onOpenAll: controller.onShowAllStat,
                      onOpenSingle: controller.onShowSingleStat,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: widget._buttonWidth,
                        child: SubmitAnswerButton(
                          buttonType: ButtonType.main,
                          hitter: hitterQuiz.enteredHitter,
                          onTapSubmitAnswer: () => controller
                              .onSubmitAnswer(hitterQuiz.enteredHitter?.label),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: SizedBox(
                        width: widget._buttonWidth,
                        child: RetireButton(
                          buttonType: ButtonType.sub,
                          onTapRetire: controller.onTapRetire,
                        ),
                      ),
                    ),
                    const SizedBox(height: 120),
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
