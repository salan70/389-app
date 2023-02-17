import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../../../application/admob/interstitial_ad_service.dart';
import '../../../../../application/quiz/hitter_quiz/hitter_quiz_service.dart';
import '../../../../../application/quiz/hitter_quiz/hitter_quiz_state.dart';
import '../../../../../application/widget/widget_state.dart';
import '../../../../../domain/entity/hitter.dart';
import '../../page/quiz_result/quiz_result_page.dart';
import 'incorrect_dialog.dart';

class AnswerWidget extends ConsumerStatefulWidget {
  const AnswerWidget({super.key, required this.retireConfirmText});

  final String retireConfirmText;

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
                    // 「Do not use BuildContexts across async gaps.」
                    // というLintの警告を回避するためにnavigatorを切り出し
                    // 上記警告は、contextに対してawaitすると発生すると思われる
                    final navigator = Navigator.of(context);

                    // interstitial広告を作成
                    final interstitialAdService =
                        ref.read(interstitialAdServiceProvider);
                    await interstitialAdService.createAd();

                    isCorrectNotifier.state =
                        hitterQuizService.isCorrectHitterQuiz();

                    await interstitialAdService.waitResult();

                    // 正解の場合
                    if (isCorrectNotifier.state) {
                      await navigator.push(
                        MaterialPageRoute<Widget>(
                          builder: (_) => const QuizResultPage(),
                        ),
                      );
                    }
                    // 不正解の場合
                    else {
                      hitterQuizService.addIncorrectCount();

                      // interstitial広告を確率で表示
                      if (interstitialAdService.isShownAds()) {
                        await interstitialAdService.showAd();
                      }

                      // TODO(me): 一旦ignoreで甘えた。
                      // ignore: use_build_context_synchronously
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return IncorrectDialog(
                            selectedHitter: textEditingController.text,
                            retireConfirmText: widget.retireConfirmText,
                          );
                        },
                      );
                    }
                  },
            child: const Text('回答する'),
          ),
        ),
      ],
    );
  }
}
