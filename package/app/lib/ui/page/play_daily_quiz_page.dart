import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../component/ad/banner_ad_widget.dart';
import '../component/common/button/my_button.dart';
import '../component/play_quiz_common/input_answer_text_field.dart';
import '../component/play_quiz_common/quiz_event_buttons.dart';
import '../component/play_quiz_common/quiz_widget.dart';
import '../component/play_quiz_common/retire_button.dart';
import '../component/play_quiz_common/submit_answer_button.dart';
import '../component/play_quiz_daily/life_widget.dart';
import '../controller/play_daily_quiz_page_controller.dart';

@RoutePage()
class PlayDailyQuizPage extends ConsumerStatefulWidget {
  PlayDailyQuizPage({super.key, required this.questionedAt});

  /// 対象となる DailyQuiz の出題日。
  final DateTime questionedAt;

  final _textEditingController = TextEditingController();
  final _buttonWidth = 160.0;

  @override
  ConsumerState<PlayDailyQuizPage> createState() => _PlayDailyQuizPageState();
}

class _PlayDailyQuizPageState extends ConsumerState<PlayDailyQuizPage> {
  @override
  void initState() {
    super.initState();

    Future(() async {
      // dailyQuizResultを保存（新規作成）する。
      await ref
          .read(quizResultServiceProvider)
          .createDailyQuizResult(widget.questionedAt);
    });
  }

  @override
  void dispose() {
    widget._textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncHitterQuiz = ref.watch(
      hitterQuizNotifierProvider(
        QuizType.daily,
        questionedAt: widget.questionedAt,
      ),
    );

    final controller = ref.watch(playDailyQuizPageControllerProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                      LifeWidget(incorrectCount: hitterQuiz.incorrectCount),
                      const SizedBox(height: 16),
                      QuizWidget(hitterQuiz: hitterQuiz),
                      const SizedBox(height: 16),
                      InputAnswerTextField(
                        textEditingController: widget._textEditingController,
                        onSearchHitter: () async => controller.onSearchHitter(
                          widget.questionedAt,
                          widget._textEditingController.text,
                        ),
                        onSelectedHitter: (value) => controller
                            .onSelectedHitter(widget.questionedAt, value),
                      ),
                      const SizedBox(height: 16),
                      QuizEventButtons(
                        onOpenAll: () =>
                            controller.onShowAllStat(widget.questionedAt),
                        onOpenSingle: () =>
                            controller.onShowSingleStat(widget.questionedAt),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: widget._buttonWidth,
                          child: SubmitAnswerButton(
                            buttonType: ButtonType.main,
                            hitter: hitterQuiz.enteredHitter,
                            onTapSubmitAnswer: () async =>
                                controller.onTapSubmitAnswer(
                              hitterQuiz.enteredHitter?.label,
                              widget.questionedAt,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: widget._buttonWidth,
                          child: RetireButton(
                            buttonType: ButtonType.sub,
                            onTapRetire: () async =>
                                controller.onTapRetire(widget.questionedAt),
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
      ),
    );
  }
}