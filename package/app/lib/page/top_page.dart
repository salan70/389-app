import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../controller/top_page_controller.dart';
import '../core/common_widget/button/my_button.dart';
import '../core/common_widget/navigation_button/to_gallery_button.dart';
import '../core/common_widget/navigation_button/to_quiz_setting_button.dart';
import '../feature/ad/banner_ad_widget.dart';
import '../feature/play_daily_quiz/start_todays_daily_quiz_button.dart';
import '../feature/play_normal_quiz/start_normal_quiz_from_top_button.dart';
import '../feature/setting/force_update_dialog.dart';
import '../feature/setting/icon_widget.dart';
import '../feature/setting/open_setting_button.dart';

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
                    child: OpenSettingButton(buttonType: ButtonType.sub),
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
                        child: ToQuizSettingButton(buttonType: ButtonType.sub),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: _buttonWidth,
                        child: StartNormalQuizFromTopButton(
                          buttonType: ButtonType.main,
                          onPressed: controller.startNormalQuiz,
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: _buttonWidth,
                        child: StartTodaysDailyQuizButton(
                          buttonType: ButtonType.sub,
                          onPressed: controller.startTodaysDailyQuiz,
                        ),
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
