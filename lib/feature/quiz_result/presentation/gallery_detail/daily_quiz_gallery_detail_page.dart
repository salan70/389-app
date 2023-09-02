import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../util/constant/strings_constant.dart';
import '../../../../common_widget/back_button.dart' as common;
import '../../../../util/constant/button_type_constant.dart';
import '../../../admob/presentation/banner_ad_widget.dart';
import '../../../quiz/presentation/component/result_quiz_widget.dart';
import '../../../quiz/presentation/component/share_button.dart';
import 'component/result_info_widget.dart';
import 'component/result_rank_label_widget.dart';
import 'component/show_answer_button.dart';

class DailyQuizGalleryDetailPage extends StatelessWidget {
  const DailyQuizGalleryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    const shareText = '#389quiz\n$appStoreUrl';
    const buttonWidth = 160.0;
    final globalKey = GlobalKey();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: ListView(
            children: [
              const BannerAdWidget(),
              const SizedBox(height: 16),
              const ResultRankLabelWidget(),
              const SizedBox(height: 16),
              ResultQuizWidget(globalKey: globalKey),
              const SizedBox(height: 8),
              const ResultInfoWidget(),
              const SizedBox(height: 8),
              const Center(
                child: SizedBox(
                  width: buttonWidth,
                  child: ShowAnswerButton(buttonType: ButtonType.main),
                ),
              ),
              const SizedBox(height: 4),
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
              const SizedBox(height: 4),
              const Center(
                child: SizedBox(
                  width: buttonWidth,
                  child: common.BackButton(buttonType: ButtonType.sub),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
