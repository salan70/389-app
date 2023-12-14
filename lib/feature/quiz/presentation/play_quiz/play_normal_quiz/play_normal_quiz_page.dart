import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../admob/presentation/banner_ad_widget.dart';
import '../../../application/hitter_quiz_notifier.dart';
import '../../component/quiz_widget.dart';
import '../component/input_answer_text_field.dart';
import '../component/quiz_event_buttons.dart';
import '../component/retire_button.dart';
import 'normal_quiz_submit_answer_button.dart';

class PlayNormalQuizPage extends ConsumerWidget {
  PlayNormalQuizPage({super.key});

  static const _buttonWidth = 160.0;
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHitterQuiz = ref
        .watch(hitterQuizNotifierProvider(QuizType.normal, questionedAt: null));

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
                    InputAnswerTextField.normal(
                      textEditingController: _textEditingController,
                    ),
                    const SizedBox(height: 16),
                    const QuizEventButtons.normal(),
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: _buttonWidth,
                        child: NormalQuizSubmitAnswerButton(
                          buttonType: ButtonType.main,
                          enteredHitter: hitterQuiz.enteredHitter,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: SizedBox(
                        width: _buttonWidth,
                        child: RetireButton.normal(buttonType: ButtonType.sub),
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
