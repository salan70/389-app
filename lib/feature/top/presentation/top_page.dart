import 'package:baseball_quiz_app/feature/push_notification/application/local_push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widget/my_button.dart';
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
  late final deviceHeight = MediaQuery.of(context).size.height;
  static const _buttonWidth = 240.0;

  @override
  void initState() {
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

      // ローカルPUSH通知の初期設定を行う。
      await ref.read(localPushNotificationServiceProvider).onAppLaunch();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 40, top: deviceHeight / 15, right: 40),
          child: const Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 120,
                    child: ToSettingButton(buttonType: ButtonType.sub),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 48),
                      IconWidget(),
                      SizedBox(height: 40),
                      SizedBox(
                        width: _buttonWidth,
                        child: ToPrepareQuizButton(buttonType: ButtonType.sub),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: _buttonWidth,
                        child: ToPlayNormalQuizFromTopButton(
                          buttonType: ButtonType.main,
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: _buttonWidth,
                        child:
                            ToPlayDailyQuizButton(buttonType: ButtonType.sub),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: _buttonWidth,
                        child: ToGalleryButton(buttonType: ButtonType.sub),
                      ),
                    ],
                  ),
                ),
                Align(
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
