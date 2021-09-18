import 'package:ad_klein_flutter_sdk/ad_klein_ad.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

class InterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterState();
}

class _InterState extends State<InterPage> {
  var _interAd;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("插屏广告"),
      ),
      body: Center(
        child: Container(
          width: width * 0.8,
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: new BoxDecoration(
            border: new Border.all(
              width: 1,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: TextButton(
            onPressed: () {
              showInterAd();
            },
            child: Text("加载广告"),
          ),
        ),
      ),
    );
  }

  // 插屏
  // 显示插屏广告请保证当时app内没有其他地方显示插屏广告，否则会有冲突
  void showInterAd() {
    if (_interAd != null) {
      return;
    }
    _interAd = ADKleinIntertitialAd(posId: Constants.interPosid());
    _interAd.onClicked = () {
      print("插屏广告关闭了");
    };
    _interAd.onFailed = () {
      print("插屏广告失败了");
      releaseInterAd();
    };
    _interAd.onExposed = () {
      print("插屏广告曝光了");
    };
    _interAd.onSucced = () {
      print("插屏广告成功了");
      playInterAd();
    };
    _interAd.onClicked = () {
      print("插屏广告点击了");
    };
    _interAd.onRewarded = () {
      print("插屏广告激励达成");
    };
    _interAd.onClosed = () {
      print("插屏广告关闭");
      releaseInterAd();
    };
    _interAd.load();
  }

  void releaseInterAd() {
    _interAd?.release();
    _interAd = null;
  }

  void playInterAd() {
    _interAd.show();
  }

  @override
  void dispose() {
    releaseInterAd();
    super.dispose();
  }
}
