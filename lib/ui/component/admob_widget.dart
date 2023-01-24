import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../util/logger.dart';

class BannerAdWidget extends ConsumerWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? dotenv.env['TEST_BANNER_ID_ANDROID']!
          : dotenv.env['TEST_BANNER_ID_IOS']!,
      size: AdSize.banner,
      request: const AdRequest(
        nonPersonalizedAds: true,
      ),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          logger.e(error);
        },
      ),
    );
    bannerAd.load();
    final adWidget = AdWidget(ad: bannerAd);

    return Container(
      alignment: Alignment.center,
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: adWidget,
    );
  }
}
