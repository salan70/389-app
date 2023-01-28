import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../util/admob.dart';
import '../../util/logger.dart';

class BannerAdWidget extends ConsumerWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureBannerAd = MyBannerAd().createBannerAd();

    return FutureBuilder(
      future: futureBannerAd,
      builder: (BuildContext context, AsyncSnapshot<BannerAd> snapshot) {
        if (snapshot.error != null) {
          logger.e('bannerAd error: ${snapshot.error}');
          return Container();
        }

        if (!snapshot.hasData) {
          return Container();
        }

        final bannerAd = snapshot.data!;
        bannerAd.load();
        final adWidget = AdWidget(ad: bannerAd);

        return Container(
          alignment: Alignment.center,
          width: bannerAd.size.width.toDouble(),
          height: bannerAd.size.height.toDouble(),
          child: adWidget,
        );
      },
    );
  }
}
