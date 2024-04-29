import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feature/app_info/application/need_update_state.dart';
import '../../feature/auth/application/auth_service.dart';
import '../../feature/push_notification/application/local_push_notification_service.dart';
import '../component/common/banner_ad_widget.dart';
import '../component/common/my_button.dart';
import '../component/setting/force_update_dialog.dart';
import '../component/setting/icon_widget.dart';
import '../component/setting/to_gallery_button.dart';
import '../component/setting/to_play_normal_quiz_from_top_button.dart';
import '../component/setting/to_play_todays_daily_quiz_button.dart';
import '../component/setting/to_prepare_quiz_button.dart';
import '../component/setting/to_setting_button.dart';


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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(left: 40, top: _deviceHeight / 15, right: 40),
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
                        child: ToPlayTodaysDailyQuizButton(
                          buttonType: ButtonType.sub,
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
