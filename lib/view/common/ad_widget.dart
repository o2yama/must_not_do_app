import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listener = BannerAdListener(
      onAdLoaded: (Ad ad) => debugPrint('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        debugPrint('Ad failed to load: $error');
      },
      onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
      onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
      onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
    );

    BannerAd bannerAd() {
      var unitId = '';
      if (Platform.isAndroid) {
        unitId = 'ca-app-pub-3723051733099960/1931918794';
      } else if (Platform.isIOS) {
        unitId = 'ca-app-pub-3723051733099960/4323591494';
      }

      final bannerAd = BannerAd(
        adUnitId: unitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: listener,
      )..load();

      return bannerAd;
    }

    return SizedBox(
      height: 50,
      child: AdWidget(ad: bannerAd()),
    );
  }
}
