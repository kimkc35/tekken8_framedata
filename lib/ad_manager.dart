import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AdManagerInterstitialAd? interstitialAd;
late BannerAd banner;

Future<void> loadAd() async{

  MobileAds.instance.initialize();

   banner = BannerAd(
      adUnitId: 'ca-app-pub-3256415400287290/4169383092',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onAdImpression: (Ad ad) => print('Ad impression.'),
      )
  )..load();

  AdManagerInterstitialAd.load(
    adUnitId: 'ca-app-pub-3256415400287290/6923530178',
    request: const AdManagerAdRequest(),
    adLoadCallback: AdManagerInterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        debugPrint('$ad loaded.');
        interstitialAd = ad;
      },
      onAdFailedToLoad: (LoadAdError error) {
        debugPrint('AdManagerInterstitialAd failed to load: $error');
      },
    )
  );
}