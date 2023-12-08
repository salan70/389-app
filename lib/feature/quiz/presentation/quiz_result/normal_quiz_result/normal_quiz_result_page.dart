import 'package:baseball_quiz_app/feature/app_review/application/app_review_service.dart';
import 'package:baseball_quiz_app/feature/app_review/application/app_review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widget/back_to_top_button.dart';
import '../../../../../common_widget/my_button.dart';
import '../../../../../util/constant/strings_constant.dart';
import '../../../../../util/logger.dart';
import '../../../../admob/presentation/banner_ad_widget.dart';
import '../../component/result_quiz_widget.dart';
import '../../component/share_button.dart';
import '../component/custom_confetti_widget.dart';
import '../component/result_text.dart';
import 'replay_button.dart';

class NormalQuizResultPage extends ConsumerStatefulWidget {
  const NormalQuizResultPage({super.key});

  @override
  ConsumerState<NormalQuizResultPage> createState() =>
      _NormalQuizResultPageState();
}

class _NormalQuizResultPageState extends ConsumerState<NormalQuizResultPage> {
  @override
  void initState() {
    super.initState();

    final appReviewService = ref.read(appReviewServiceProvider);

    Future(() async {
      final shouldRequestAppReview =
          await ref.read(shouldRequestReviewProvider.future);
      if (shouldRequestAppReview) {
        logger.i('レビュー要求するで');
        await appReviewService.maybeRequestAppReview();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    const shareText = '#プロ野球クイズ #389quiz\n$appStoreUrl';
    const buttonWidth = 200.0;

    // TODO(me): globalKeyを引数として渡すのイケてない感ある
    // 本当はProviderで参照したかった。。
    final globalKey = GlobalKey();

    return WillPopScope(
      onWillPop: () async => false,
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
                    const ResultText(),
                    ResultQuizWidget(globalKey: globalKey),
                    const SizedBox(height: 24),
                    const Center(
                      child: SizedBox(
                        width: buttonWidth,
                        child: ReplayButton(buttonType: ButtonType.main),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: SizedBox(
                        width: buttonWidth,
                        child: ShareButton(
                          buttonType: ButtonType.sub,
                          globalKey: globalKey,
                          shareText: shareText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: SizedBox(
                        width: buttonWidth,
                        child: BackToTopButton(buttonType: ButtonType.sub),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomConfettiWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
