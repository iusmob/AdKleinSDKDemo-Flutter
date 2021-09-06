import 'package:ad_klein_flutter_sdk/ad_klein_ad.dart';
import 'package:ad_klein_flutter_sdk/ad_klein_base.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

class BannerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BannerState();
}

class _BannerState extends State<BannerPage> {
  var _adKleinFlutterBannerAd;
  bool _hasInitBanner = false;

  @override
  Widget build(BuildContext context) {
    if (_adKleinFlutterBannerAd == null && _hasInitBanner == false) {
      MediaQueryData queryData = MediaQuery.of(context);
      _hasInitBanner = true;
      var width = queryData.size.width;
      var height = queryData.size.width / 320.0 * 50.0;
      _adKleinFlutterBannerAd = ADKleinFlutterBannerAd(
          posId: Constants.bannerPosid(), width: width, height: height);
      _adKleinFlutterBannerAd.loadAndShow();
      _adKleinFlutterBannerAd.onSucced = () {
        print("横幅广告加载成功");
      };
      _adKleinFlutterBannerAd.onFailed = () {
        removeBannerAd();
        print("横幅广告加载失败");
      };
      _adKleinFlutterBannerAd.onClicked = () {
        print("横幅广告点击");
      };
      _adKleinFlutterBannerAd.onExposed = () {
        print("横幅广告渲染成功");
      };
      _adKleinFlutterBannerAd.onClosed = () {
        removeBannerAd();
        print("横幅广告关闭成功");
      };
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("BannerPage"),
        ),
        body: Center(
            child: (_adKleinFlutterBannerAd == null
                ? Text("banner广告已关闭")
                : ADKleinWidget(adView: _adKleinFlutterBannerAd))));
  }

  void removeBannerAd() {
    setState(() {
      releaseBannerAd();
    });
  }

  void releaseBannerAd() {
    _adKleinFlutterBannerAd?.release();
    _adKleinFlutterBannerAd = null;
  }

  @override
  void dispose() {
    releaseBannerAd();
    super.dispose();
  }
}
