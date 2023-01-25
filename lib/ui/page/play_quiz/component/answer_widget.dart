import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../../model/ui/hitter_id_by_name.dart';
import '../../../../state/is_correct_quiz.state.dart';
import '../../../../util/admob.dart';
import '../../quiz_result/quiz_result_page.dart';
import 'answer_view_model.dart';
import 'incorrect_dialog.dart';

class AnswerWidget extends ConsumerWidget {
  const AnswerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();
    final textEditingController = TextEditingController();

    final viewModel = ref.watch(answerViewModelProvider);
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
            return viewModel.filterHitter(textEditingController.text);
          },
          getSelectedValue: (HitterIdByName value) {
            // 回答入力用のTextFieldのフォーカスを外す
            FocusManager.instance.primaryFocus?.unfocus();
            selectedHitterIdNotifier.state = value.id;
          },
        ),
        TextButton(
          onPressed: () async {
            // TODO(me): 回答が無効な値の場合、ボタンを押せなくする。
            // あるいは、押したら回答が無効な旨を表示する

            // 「Do not use BuildContexts across async gaps.」
            // というLintの警告を回避するためにnavigatorを切り出し
            // 上記警告は、contextに対してawaitすると発生すると思われる
            final navigator = Navigator.of(context);

            // interstitial広告を作成
            final interstitialAd = MyInterstitialAd();
            await interstitialAd.createAd();

            isCorrectNotifier.state = viewModel.isCorrectHitterQuiz();

            await viewModel.waitResult();

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
              if (viewModel.isShownAds()) {
                // interstitial広告を表示
                await interstitialAd.showAd();
              }

              // TODO(me): 一旦ignoreで甘えた。
              // ignore: use_build_context_synchronously
              await showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return IncorrectDialog(
                    selectedHitter: textEditingController.text,
                  );
                },
              );
            }
          },
          child: const Text('回答する'),
        ),
      ],
    );
  }
}
