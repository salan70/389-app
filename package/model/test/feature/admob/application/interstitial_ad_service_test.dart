import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:model/src/feature/admob/application/interstitial_ad_service.dart';

void main() {
  group('isShownAds関数', () {
    test('bool型を返すか確認', () {
      final result =
          ProviderContainer().read(interstitialAdServiceProvider).isShownAds();
      expect(bool, result.runtimeType);
    });
  });
}
