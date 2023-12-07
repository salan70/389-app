import 'package:baseball_quiz_app/feature/push_notification/application/local_push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/my_button.dart';
import '../../../util/constant/colors_constant.dart';
import '../application/notification_setting_state.dart';

class NotificationSettingDialog extends ConsumerWidget {
  const NotificationSettingDialog({super.key});

  static const _smallButtonWidth = 120.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // loading , error 時のハンドリングはかなり雑にやっている。
    //
    // ローカルDBからのfetchでローディングがかなり短く、エラーも起きにくく、なおかつ、
    // UI上で ON / OFF を切り替えるたびにローディングを出したくないので、これで許容している。
    return ref.watch(notificationSettingProvider).maybeWhen(
          orElse: Container.new,
          data: (notificationSetting) {
            return Dialog(
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Text('プッシュ通知の設定'),
                      const SizedBox(height: 24),
                      Center(
                        child: SwitchListTile(
                          title: const Text('今日の1問 更新のお知らせ'),
                          value: notificationSetting
                              .allowStartDailyQuizNotification,
                          onChanged: (_) => ref
                              .read(localPushNotificationServiceProvider)
                              .changeAllowStartDailyQuizNotificationSetting(),
                          activeColor: highlightColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SwitchListTile(
                          title: const Text('今日の1問 残り30分のお知らせ'),
                          value: notificationSetting
                              .allowRemindDailyQuizNotification,
                          onChanged: (_) => ref
                              .read(localPushNotificationServiceProvider)
                              .changeAllowRemindDailyQuizNotificationSetting(),
                          activeColor: highlightColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SwitchListTile(
                          title: const Text('その他のお知らせ'),
                          value: notificationSetting.allowOtherNotification,
                          onChanged: (_) => ref
                              .read(localPushNotificationServiceProvider)
                              .changeAllowOtherNotificationSetting(),
                          activeColor: highlightColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: SizedBox(
                          width: _smallButtonWidth,
                          child: _CloseButton(),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return MyButton(
      buttonName: 'close_button_in_notification_setting_dialog',
      buttonType: ButtonType.main,
      onPressed: () => Navigator.pop(context),
      child: const Center(child: Text('閉じる')),
    );
  }
}
