import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../util/constant/strings_constant.dart';
import '../../../../common_widget/back_button.dart' as common;
import '../../../../common_widget/my_button.dart';
import '../../../../util/constant/hitting_stats_constant.dart';
import '../../../admob/presentation/banner_ad_widget.dart';
import '../../../quiz/application/hitter_quiz_notifier.dart';
import '../../../quiz/presentation/component/result_quiz_widget.dart';
import '../../../quiz/presentation/component/share_button.dart';
import 'component/result_info_widget.dart';
import 'component/result_rank_label_widget.dart';
import 'component/show_answer_button.dart';

class DailyQuizGalleryDetailPage extends ConsumerWidget {
  DailyQuizGalleryDetailPage({super.key});

  static const _shareText = '#プロ野球クイズ #389quiz\n$appStoreUrl';
  static const _buttonWidth = 160.0;
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final asyncHitterQuiz =
        ref.watch(hitterQuizNotifierProvider(QuizType.daily));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: asyncHitterQuiz.maybeWhen(
            orElse: Container.new,
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (hitterQuiz) {
              return ListView(
                children: [
                  const BannerAdWidget(),
                  const SizedBox(height: 16),
                  const ResultRankLabelWidget(),
                  const SizedBox(height: 16),
                  ResultQuizWidget(
                    globalKey: _globalKey,
                    hitterQuiz: hitterQuiz,
                  ),
                  const SizedBox(height: 8),
                  const ResultInfoWidget(),
                  const SizedBox(height: 8),
                  const Center(
                    child: SizedBox(
                      width: _buttonWidth,
                      child:
                          ShowAnswerButton.daily(buttonType: ButtonType.main),
                    ),
                  ),
                  const SizedBox(height: 4),
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
                  const SizedBox(height: 4),
                  const Center(
                    child: SizedBox(
                      width: _buttonWidth,
                      child: common.BackButton(buttonType: ButtonType.sub),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
