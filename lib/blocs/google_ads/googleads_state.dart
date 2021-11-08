part of 'googleads_cubit.dart';

enum AdsStatus {
  initial,
  loading,
  loaded,
  error,
}

class GoogleAdsState extends Equatable {
  final Future<InitializationStatus> adsState;
  final AdsStatus status;

  final _bannerAdListener = BannerAdListener(

    onAdLoaded: (Ad ad) {

    },
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
 
      ad.dispose();
      
    },


  );

  BannerAd createBannerAd() {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: AdRequest(),
      listener: _bannerAdListener,
    );
  }

  GoogleAdsState({
    @required this.adsState,
    @required this.status,
  });

  factory GoogleAdsState.initial() {
    return GoogleAdsState(
      adsState: MobileAds.instance.initialize(),
      status: AdsStatus.initial,
    );
  }

  @override
  List<Object> get props => [adsState, status];

  GoogleAdsState copyWith({
    Future<InitializationStatus> adsState,
    AdsStatus status,
    BannerAd bannerAd,
  }) {
    return GoogleAdsState(
      adsState: adsState ?? this.adsState,
      status: status ?? this.status,
    );
  }
}
