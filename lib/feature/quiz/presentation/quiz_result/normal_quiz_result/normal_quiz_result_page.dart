import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../presentation/components/back_to_top_button.dart';
import '../../../../../util/constant/strings_constant.dart';
import '../../../../admob/presentation/banner_ad_widget.dart';
import '../../component/result_quiz_widget.dart';
import '../../component/share_button.dart';
import '../component/custom_confetti_widget.dart';
import '../component/result_text.dart';
import 're_prepare_quiz_button.dart';
import 'replay_button.dart';

class NormalQuizResultPage extends StatelessWidget {
  const NormalQuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    const shareText = '#389quiz\n$storeUrl';

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
                    const SizedBox(height: 16),
                    ResultQuizWidget(globalKey: globalKey),
                    const SizedBox(height: 8),
                    const ReplayButton(),
                    const SizedBox(height: 8),
                    ShareButton(globalKey: globalKey, shareText: shareText),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        BackToTopButton(),
                        RePrepareQuizButton(),
                      ],
                    ),
                    const SizedBox(height: 80),
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
