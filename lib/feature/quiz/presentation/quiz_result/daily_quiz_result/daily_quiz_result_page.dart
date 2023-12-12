import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/back_to_top_button.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/hitting_stats_constant.dart';
import '../../../../../util/constant/strings_constant.dart';
import '../../../../admob/presentation/banner_ad_widget.dart';
import '../../../application/hitter_quiz_notifier.dart';
import '../../component/result_quiz_widget.dart';
import '../../component/share_button.dart';
import '../component/custom_confetti_widget.dart';
import '../component/result_text.dart';

class DailyQuizResultPage extends ConsumerWidget {
  DailyQuizResultPage({super.key});

  static const _shareText = '#プロ野球クイズ #389quiz #今日の1問\n$appStoreUrl';
  static const _buttonWidth = 160.0;
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final asyncHitterQuiz =
        ref.watch(hitterQuizNotifierProvider(QuizType.daily));

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: asyncHitterQuiz.maybeWhen(
            orElse: Container.new,
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (hitterQuiz) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView(
                      children: [
                        const BannerAdWidget(),
                        const SizedBox(height: 16),
                        ResultText.daily(hitterQuiz: hitterQuiz),
                        ResultQuizWidget(
                          globalKey: _globalKey,
                          hitterQuiz: hitterQuiz,
                        ),
                        const SizedBox(height: 24),
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
                            child: BackToTopButton(buttonType: ButtonType.main),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomConfettiWidget(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
