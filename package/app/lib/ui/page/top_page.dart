import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../component/ad/banner_ad_widget.dart';
import '../component/ad/open_hide_ad_dialog_button.dart';
import '../component/common/button/my_button.dart';
import '../component/common/navigation_button/to_gallery_button.dart';
import '../component/common/navigation_button/to_quiz_setting_button.dart';
import '../component/play_quiz_daily/start_todays_daily_quiz_button.dart';
import '../component/play_quiz_normal/start_normal_quiz_from_top_button.dart';
import '../component/setting/force_update_dialog.dart';
import '../component/setting/icon_widget.dart';
import '../component/setting/open_setting_button.dart';
import '../controller/common/navigator_key_controller.dart';
import '../controller/top_page_controller.dart';

@RoutePage()
class TopPage extends ConsumerStatefulWidget {
  const TopPage({super.key});

  @override
  ConsumerState<TopPage> createState() => _TopPageState();
}

class _TopPageState extends ConsumerState<TopPage> {
  late final _deviceHeight = MediaQuery.of(context).size.height;
  static const _buttonWidth = 240.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ログインする。
      await ref.read(authServiceProvider).login();

      // バージョンチェック
      final needUpdate = await ref.read(needUpdateProvider.future);
      if (needUpdate) {
        ref.read(navigatorKeyControllerProvider).showDialogWithChild(
              child: const ForceUpdateDialog(),
              barrierDismissible: false,
            );
      }

      // ローカルPUSH通知の初期設定を行う。
      await ref.read(localPushNotificationServiceProvider).onAppLaunch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(topPageControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(left: 40, top: _deviceHeight / 15, right: 40),
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 120,
                    child: OpenSettingButton(
                      buttonType: ButtonType.sub,
                      onTap: controller.onTapOpenSetting,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                const IconWidget(),
                Expanded(
                  child: SizedBox(
                    width: _buttonWidth,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        const SizedBox(
                          width: _buttonWidth,
                          child:
                              ToQuizSettingButton(buttonType: ButtonType.sub),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: _buttonWidth,
                          child: StartNormalQuizFromTopButton(
                            buttonType: ButtonType.main,
                            onPressed: controller.startNormalQuiz,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: _buttonWidth,
                          child: StartTodaysDailyQuizButton(
                            buttonType: ButtonType.sub,
                            onPressed: controller.onTapPlayTodaysDailyQuiz,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(
                          width: _buttonWidth,
                          child: ToGalleryButton(buttonType: ButtonType.sub),
                        ),
                        const SizedBox(height: 48),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: OpenHideAdDialogButton(
                            buttonWidth: _buttonWidth / 3,
                          ),
                        ),
                      ],
                    ),
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
