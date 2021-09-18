import 'package:ad_klein_flutter_sdk/ad_klein_ad.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

class FullScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FullScreenState();
}

class FullScreenState extends State<FullScreenPage> {
  var _fullScreenVodAd;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("全屏视频广告"),
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
              showFullScreenVodAd();
            },
            child: Text("加载广告"),
          ),
        ),
      ),
    );
  }

  // 全屏视频
  // 显示全屏视频广告请保证当时app内没有其他地方显示全屏视频广告，否则会有冲突
  void showFullScreenVodAd() {
    if (_fullScreenVodAd != null) {
      return;
    }
    _fullScreenVodAd =
        ADKleinFullScreenVodAd(posId: Constants.fullScreenPosid());
    _fullScreenVodAd.onClicked = () {
      print("全屏视频广告关闭了");
    };
    _fullScreenVodAd.onFailed = () {
      print("全屏视频广告失败了");
      releaseFullScreenVodAd();
    };
    _fullScreenVodAd.onExposed = () {
      print("全屏视频广告曝光了");
    };
    _fullScreenVodAd.onSucced = () {
      print("全屏视频广告成功了");
      playFullScreenVodAd();
    };
    _fullScreenVodAd.onClicked = () {
      print("全屏视频广告点击了");
    };
    _fullScreenVodAd.onRewarded = () {
      print("全屏视频广告激励达成");
    };
    _fullScreenVodAd.onClosed = () {
      print("全屏视频广告关闭");
      releaseFullScreenVodAd();
    };
    _fullScreenVodAd.load();
  }

  void releaseFullScreenVodAd() {
    _fullScreenVodAd?.release();
    _fullScreenVodAd = null;
  }

  void playFullScreenVodAd() {
    _fullScreenVodAd.show();
  }

  @override
  void dispose() {
    releaseFullScreenVodAd();
    super.dispose();
  }
}
