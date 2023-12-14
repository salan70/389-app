import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../util/logger.dart';
import '../application/banner_ad_id_state.dart';

class BannerAdWidget extends ConsumerWidget {
  const BannerAdWidget({super.key});

  static const _buttonHeight = 64.0;
  static const _buttonWidth = double.infinity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBannerAdId = ref.watch(bannerAdIdProvider);

    return asyncBannerAdId.when(
      data: (bannerAdId) {
        return SizedBox(
          height: _buttonHeight,
          width: _buttonWidth,
          child: AdWidget(
            ad: BannerAd(
              size: AdSize.banner,
              adUnitId: bannerAdId,
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
      error: (e, s) {
        logger.e('バナー広告でエラーが発生', e, s);
        return const SizedBox.shrink();
      },
      loading: () => const SizedBox(
        height: _buttonHeight,
        width: _buttonWidth,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
