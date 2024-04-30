import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../core/common_widget/button/back_to_top_button.dart';
import '../core/common_widget/button/my_button.dart';
import '../feature/ad/banner_ad_widget.dart';
import '../feature/quiz_result/custom_confetti_widget.dart';
import '../feature/quiz_result/replay_button.dart';
import '../feature/quiz_result/result_quiz_widget.dart';
import '../feature/quiz_result/result_text.dart';
import '../feature/quiz_result/share_button.dart';

@RoutePage()
class NormalQuizResultPage extends ConsumerWidget {
  NormalQuizResultPage({super.key});

  static const _buttonWidth = 200.0;
  static const _shareText = '#プロ野球クイズ #389quiz\n$appStoreUrl';

  // Widget の画像を作成するために使用する。
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final normalHitterQuizNotifierProvider =
        hitterQuizNotifierProvider(QuizType.normal, questionedAt: null);

    ref.listen(
      normalHitterQuizNotifierProvider,
      (_, next) async {
        final nextHitterQuiz = next! as AsyncData<HitterQuiz>;
        // 直近のクイズが不正解だった場合、何もしない。
        if (nextHitterQuiz.value.isCorrect == false) {
          return;
        }

        final shouldRequestAppReview =
            await ref.read(shouldRequestReviewProvider.future);
        // レビューを要求する条件を満たしていない場合、何もしない。
        if (shouldRequestAppReview == false) {
          return;
        }

        // レビューダイアログを表示したことを記録する。
        await ref.read(appReviewServiceProvider).updateReviewHistory();

        // レビューダイアログを表示する。
        if (context.mounted) {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return const _RequestReviewDialog();
            },
          );
        }
      },
    );

    final asyncHitterQuiz = ref.watch(normalHitterQuizNotifierProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: asyncHitterQuiz.maybeWhen(
              orElse: Container.new,
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (hitterQuiz) {
                return Stack(
                  children: [
                    ListView(
                      children: [
                        const BannerAdWidget(),
                        const SizedBox(height: 16),
                        ResultText.normal(hitterQuiz: hitterQuiz),
                        ResultQuizWidget(
                          globalKey: _globalKey,
                          hitterQuiz: hitterQuiz,
                        ),
                        const SizedBox(height: 24),
                        const Center(
                          child: SizedBox(
                            width: _buttonWidth,
                            child: ReplayButton(buttonType: ButtonType.main),
                          ),
                        ),
                        const SizedBox(height: 8),
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
                            child: BackToTopButton(buttonType: ButtonType.sub),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child:
                          CustomConfettiWidget(isCorrect: hitterQuiz.isCorrect),
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

class _RequestReviewDialog extends ConsumerWidget {
  const _RequestReviewDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(
        'レビューをお願いします！',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      content: const Text('''.389をお楽しみいただきありがとうございます！
    \n少しでも.389を気に入っていただけましたら、5秒で終わりますので、是非星5のレビューをお願いします。
    \nレビューをいただけると、開発者のモチベーションが上がり、はしゃぎます。
    \nより一層楽しいアプリへの改善に繋がりますので、ご協力をお願いします！
    '''),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.only(right: 20, bottom: 8, left: 20),
      actions: [
        MyButton(
          buttonName: 'cancel_button_in_request_review_dialog',
          buttonType: ButtonType.sub,
          onPressed: context.popRoute,
          child: const Text('今はやめとく'),
        ),
        MyButton(
          buttonName: 'ok_button_in_request_review_dialog',
          buttonType: ButtonType.main,
          onPressed: () async {
            await context.popRoute();
            await ref.read(appReviewServiceProvider).requestAppReview();
          },
          child: const Text('レビューする！'),
        ),
      ],
    );
  }
}
