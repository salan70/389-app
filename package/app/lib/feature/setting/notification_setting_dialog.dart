import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../../core/common_widget/button/my_button.dart';
import '../../../core/util/colors_constant.dart';

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
                          title: const Text('今日の1問の更新'),
                          subtitle: Text(
                            '毎日$borderHourForTodayInApp時に通知します。',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Colors.black54,
                                ),
                          ),
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
                          title: const Text('今日の1問のリマインド'),
                          subtitle: Text(
                            '今日の1問を未プレイの場合、\n'
                            '終了30分前に通知します。',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Colors.black54,
                                ),
                          ),
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
                          title: const Text('その他'),
                          subtitle: Text(
                            'その他のお知らせを不定期で\n通知します。',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Colors.black54,
                                ),
                          ),
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
      onPressed: context.popRoute,
      child: const Center(child: Text('閉じる')),
    );
  }
}
