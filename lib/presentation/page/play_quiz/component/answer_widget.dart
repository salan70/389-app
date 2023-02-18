import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../../../application/admob/interstitial_ad_service.dart';
import '../../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';
import '../../../../../application/quiz/hitter_quiz/hitter_quiz_state.dart';
import '../../../../../application/widget/widget_state.dart';
import '../../../../../domain/entity/hitter.dart';
import '../../../component/confirm_dialog.dart';
import 'incorrect_dialog.dart';

/// maxCanAnswerCount: 間違えれる数。制限がない場合はnullを渡す
class AnswerWidget extends ConsumerStatefulWidget {
  const AnswerWidget({
    super.key,
    required this.retireConfirmText,
    required this.maxCanIncorrectCount,
    required this.resultPage,
  });

  final String retireConfirmText;
  final int? maxCanIncorrectCount;
  final Widget resultPage;

  @override
  ConsumerState<AnswerWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<AnswerWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(answerTextFieldProvider).clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final textEditingController = ref.watch(answerTextFieldProvider);

    final hitterQuizService = ref.watch(hitterQuizServiceProvider);

    final selectedHitterId = ref.watch(selectedHitterIdProvider);
    final selectedHitterIdNotifier =
        ref.watch(selectedHitterIdProvider.notifier);

    final isCorrectNotifier = ref.watch(isCorrectQuizStateProvider.notifier);

    // TODO(me): viewでやるべきではない気がするから、
    // application等に委譲できないか検討する
    Future<void> submitAnswer({required bool isFinalAnswer}) async {
      final navigator = Navigator.of(context);

      // interstitial広告を作成
      final interstitialAdService = ref.read(interstitialAdServiceProvider);
      await interstitialAdService.createAd();

      isCorrectNotifier.state = hitterQuizService.isCorrectHitterQuiz();

      await interstitialAdService.waitResult();

      // 正解の場合
      if (isCorrectNotifier.state) {
        await navigator.push(
          MaterialPageRoute<Widget>(
            builder: (_) => widget.resultPage,
          ),
        );
        return;
      }
      // 不正解の場合
      hitterQuizService.addIncorrectCount();

      // interstitial広告を確率で表示
      if (interstitialAdService.isShownAds()) {
        await interstitialAdService.showAd();
      }

      // 最後の回答の場合
      if (isFinalAnswer) {
        await navigator.push(
          MaterialPageRoute<Widget>(
            builder: (_) => widget.resultPage,
          ),
        );
        return;
      }

      // 最後の回答でない場合
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return IncorrectDialog(
            selectedHitter: textEditingController.text,
            retireConfirmText: widget.retireConfirmText,
            resultPage: widget.resultPage,
          );
        },
      );
    }

    return Column(
      children: [
        TextFieldSearch(
          label: '選手名',
          controller: textEditingController,
          minStringLength: 0,
          itemsInView: 5,
          scrollbarDecoration: ScrollbarDecoration(
            controller: scrollController,
            theme: const ScrollbarThemeData(),
          ),
          future: () {
            selectedHitterIdNotifier.state = '';
            return hitterQuizService.searchHitter(textEditingController.text);
          },
          getSelectedValue: (Hitter value) {
            // 回答入力用のTextFieldのフォーカスを外す
            FocusManager.instance.primaryFocus?.unfocus();
            selectedHitterIdNotifier.state = value.id;
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 120,
          child: TextButton(
            onPressed: selectedHitterId == ''
                ? null
                : () async {
                    // 間違えれる回数が上限に達している（最後の回答を送信している）場合、
                    // 確認ダイアログを表示する
                    final isFinalAnswer = hitterQuizService
                        .isFinalAnswer(widget.maxCanIncorrectCount);

                    if (isFinalAnswer) {
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return ConfirmDialog(
                            confirmText: 'これが最後のチャンスです。\n本当にその回答でよろしいですか？',
                            onPressedYes: () async {
                              await submitAnswer(isFinalAnswer: true);
                            },
                          );
                        },
                      );
                      return;
                    }

                    await submitAnswer(isFinalAnswer: false);
                  },
            child: const Text('回答する'),
          ),
        ),
      ],
    );
  }
}
