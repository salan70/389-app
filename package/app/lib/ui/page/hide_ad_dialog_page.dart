import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

import '../../core/util/app_constant.dart';
import '../../core/util/extension/context_extension.dart';
import '../component/common/button/my_button.dart';
import '../component/common/sized_circular_indicator.dart';
import '../controller/hide_ad_dialog_page_controller.dart';

/// 広告を非表示にするためのリワード広告再生ダイアログ。
///
/// 周りを半透明にすることでダイアログを模している。
/// 処理や状態管理が複雑で、 `controller` を持ちたいために `XXPage` という命名にしている。
class HideAdDialogPage extends ConsumerWidget {
  const HideAdDialogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(hideAdDialogPageControllerProvider);

    return asyncState.when(
      data: (state) => _HideAdDialog.normal(
        rewardedAdWatchCount: state.rewardedAdWatchCount,
        adFreePeriodEndDate: state.adFreePeriodEndDate,
        isDailyQuizPlayed: state.isDailyQuizPlayed,
        // リワード広告が見れる場合のみ、ボタンタップ時に処理を実行する。
        onTapWatchRewardedAd: state.canWatchRewardedAd
            ? () => ref
                .read(hideAdDialogPageControllerProvider.notifier)
                .onTapWatchRewardedAd()
            : null,
      ),
      loading: () => const _HideAdDialog.loading(),
      error: (e, s) {
        logger.e('hideAdDialogPageControllerProvider でエラーが発生。', e, s);
        return const _HideAdDialog.error();
      },
    );
  }
}

enum _HideAdDialogType {
  /// 通常の状態。
  normal,

  /// ロード中。
  loading,

  /// エラー。
  error,

  /// すでにリワード広告を上限まで視聴済み。
  alreadyWatchedMax;
}

class _HideAdDialog extends StatelessWidget {
  const _HideAdDialog.loading()
      : type = _HideAdDialogType.loading,
        rewardedAdWatchCount = null,
        adFreePeriodEndDate = null,
        isDailyQuizPlayed = null,
        onTapWatchRewardedAd = null;

  const _HideAdDialog.normal({
    required this.rewardedAdWatchCount,
    required this.adFreePeriodEndDate,
    required this.isDailyQuizPlayed,
    required this.onTapWatchRewardedAd,
  }) : type = rewardedAdWatchCount != null &&
                rewardedAdWatchCount < maxRewardedAdWatchCount
            ? _HideAdDialogType.normal
            : _HideAdDialogType.alreadyWatchedMax;

  const _HideAdDialog.error()
      : type = _HideAdDialogType.error,
        rewardedAdWatchCount = null,
        adFreePeriodEndDate = null,
        isDailyQuizPlayed = null,
        onTapWatchRewardedAd = null;

  /// [_HideAdDialog] の種類。
  final _HideAdDialogType type;

  /// リワード広告の視聴回数。
  ///
  /// [_HideAdDialog.normal] 以外の場合は `null` となる。
  final int? rewardedAdWatchCount;

  /// 広告非表示期間の終了日時。
  ///
  /// [_HideAdDialog.normal] 以外の場合は `null` となる。
  final DateTime? adFreePeriodEndDate;

  /// デイリークイズをプレイ済みかどうか。
  ///
  /// [_HideAdDialog.normal] 以外の場合は `null` となる。
  final bool? isDailyQuizPlayed;

  /// 広告を見るボタンを押したときのコールバック。
  ///
  /// [_HideAdDialog.normal] 以外の場合は `null` となる。
  final VoidCallback? onTapWatchRewardedAd;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '動画広告1回視聴で1時間広告なし！\n'
            '2回視聴 +「今日の1問」プレイで次の19時まで広告なし！',
            textAlign: TextAlign.start,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              '※動画広告の視聴は1日2回までです。',
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          AdStatusIcons(
            rewardedAdWatchCount: rewardedAdWatchCount ?? 0,
            isDailyQuizPlayed: isDailyQuizPlayed ?? false,
          ),
          const SizedBox(height: 8),
          adFreePeriodEndDate != null
              ? AdFreePeriodText(adFreePeriodEndDate: adFreePeriodEndDate!)
              // 画面上のズレを防ぐために、空の `Text` を配置する。
              : const Text(''),
        ],
      ),
      actionsPadding: const EdgeInsets.only(bottom: 8, right: 24),
      actions: <Widget>[
        MyButton(
          buttonName: 'confirm_no_button',
          buttonType: ButtonType.sub,
          onPressed: context.pop,
          child: const Text('閉じる'),
        ),
        SizedBox(
          width: 96,
          child: MyButton(
            buttonName: 'confirm_yes_button',
            buttonType: type == _HideAdDialogType.alreadyWatchedMax
                ? ButtonType.disabled
                : ButtonType.alert,
            onPressed: onTapWatchRewardedAd,
            child: switch (type) {
              _HideAdDialogType.normal => const Text('広告を見る'),
              _HideAdDialogType.loading =>
                const SizedCircularIndicator(size: 24),
              _HideAdDialogType.error => const Text('リトライ'),
              _HideAdDialogType.alreadyWatchedMax => const Text('視聴済み'),
            },
          ),
        ),
      ],
    );
  }
}

class AdStatusIcons extends StatelessWidget {
  const AdStatusIcons({
    super.key,
    required this.rewardedAdWatchCount,
    required this.isDailyQuizPlayed,
  });

  /// リワード広告の視聴回数。
  final int rewardedAdWatchCount;

  /// デイリークイズをプレイ済みかどうか。
  final bool isDailyQuizPlayed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // * リワード広告の視聴状況を表す `Icon`
        _AdStatusIcon(
          isChecked: rewardedAdWatchCount >= 1,
          color: Colors.blue,
        ),
        const SizedBox(width: 16),
        _AdStatusIcon(
          isChecked: rewardedAdWatchCount >= 2,
          color: Colors.blue,
        ),
        const SizedBox(width: 16),
        // * デイリークイズのプレイ状況を表す `Icon`
        _AdStatusIcon(
          isChecked: isDailyQuizPlayed,
          color: Colors.orange,
        ),
      ],
    );
  }
}

class _AdStatusIcon extends StatelessWidget {
  const _AdStatusIcon({
    required this.isChecked,
    required this.color,
  });

  final bool isChecked;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isChecked
          ? Icons.check_box_rounded
          : Icons.check_box_outline_blank_rounded,
      size: 64,
      color: isChecked ? color : color.withOpacity(0.2),
    );
  }
}

class AdFreePeriodText extends StatelessWidget {
  const AdFreePeriodText({
    super.key,
    required this.adFreePeriodEndDate,
  });

  final DateTime adFreePeriodEndDate;

  @override
  Widget build(BuildContext context) {
    return Text('${adFreePeriodEndDate.toFormattedStringWithTime()}まで広告なし！');
  }
}
