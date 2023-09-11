import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/constant/button_type_constant.dart';
import '../../admob/presentation/banner_ad_widget.dart';
import '../../app_info/application/app_info_service.dart';
import '../../app_info/presentation/force_update_dialog.dart';
import '../../daily_quiz/presentation/to_play_daily_quiz_button.dart';
import 'component/icon_widget.dart';
import 'component/to_gallery_button.dart';
import 'component/to_play_normal_quiz_from_top_button.dart';
import 'component/to_prepare_quiz_button.dart';
import 'component/to_setting_button.dart';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({super.key});

  @override
  ConsumerState<TopPage> createState() => _TopPageState();
}

class _TopPageState extends ConsumerState<TopPage> {
  @override
  void initState() {
    print('test: start initState()');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // バージョンチェック
      final needUpdate = await ref.read(appInfoServiceProvider).needUpdate();
      if (needUpdate) {
        if (context.mounted) {
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ForceUpdateDialog(),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final deviceHeight = MediaQuery.of(context).size.height;
    const buttonWidth = 240.0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 40, top: deviceHeight / 15, right: 40),
          child: Center(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 120,
                    child: ToSettingButton(buttonType: ButtonType.sub),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      SizedBox(height: 48),
                      IconWidget(),
                      SizedBox(height: 40),
                      SizedBox(
                        width: buttonWidth,
                        child: ToPrepareQuizButton(buttonType: ButtonType.sub),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ToPlayNormalQuizFromTopButton(
                          buttonType: ButtonType.main,
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: buttonWidth,
                        child:
                            ToPlayDailyQuizButton(buttonType: ButtonType.sub),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ToGalleryButton(buttonType: ButtonType.sub),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BannerAdWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
