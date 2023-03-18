import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../util/constant/strings_constant.dart';
import '../../../admob/presentation/banner_ad_widget.dart';
import '../../../quiz/presentation/component/result_quiz_widget.dart';
import '../../../quiz/presentation/component/share_button.dart';

class NormalQuizGalleryDetailPage extends StatelessWidget {
  const NormalQuizGalleryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    const shareText = '#389quiz\n$storeUrl';

    // TODO(me): globalKeyを引数として渡すのイケてない感ある
    // 本当はProviderで参照したかった。。
    final globalKey = GlobalKey();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: ListView(
            children: [
              const BannerAdWidget(),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              ResultQuizWidget(globalKey: globalKey),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              ShareButton(globalKey: globalKey, shareText: shareText),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
