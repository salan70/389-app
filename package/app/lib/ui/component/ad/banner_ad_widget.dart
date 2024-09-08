import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:model/model.dart';

class BannerAdWidget extends ConsumerWidget {
  const BannerAdWidget({super.key});

  static const _buttonHeight = 64.0;
  static const _buttonWidth = double.infinity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncIsAdFree = ref.watch(isAdFreePeriodProvider);

    return asyncIsAdFree.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: (isAdFree) {
        // 広告非表示期間中は広告を表示しない。
        if (isAdFree) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: _buttonHeight,
          width: _buttonWidth,
          child: AdWidget(
            ad: BannerAd(
              size: AdSize.banner,
              adUnitId: ref.watch(flavorProvider).bannerId,
              request: const AdRequest(),
              listener: BannerAdListener(
                onAdFailedToLoad: (Ad ad, LoadAdError error) {
                  ad.dispose();
                  logger.e('BannerAdの読み込みに失敗しました。 error: $error');
                },
              ),
            )..load(),
          ),
        );
      },
    );
  }
}
