import 'package:ad_klein_demo_flutter/home.dart';
import 'package:ad_klein_flutter_sdk/ad_klein_ad.dart';
import 'package:ad_klein_flutter_sdk/ad_klein_flutter_sdk.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

void main() {
  runApp(MaterialApp(title: 'ADKlein广告Demo_Flutter', home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getIDFA();
    AdKleinFlutterSdk.initSdk(appid: Constants.appKey());
  }

  var _splashAd;

  //申请idfa
  void getIDFA() async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
    print("status = $status");
  }

  @override
  Widget build(BuildContext context) {
    showSplashAd();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // 屏幕宽度
        height: MediaQuery.of(context).size.height, // 屏幕高度
        child: Image.asset(
          "images/opening.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 开屏
  // 显示开屏广告请保证当时app内没有其他地方显示开屏广告，否则会有冲突
  void showSplashAd() {
    if (_splashAd != null) {
      return;
    }
    _splashAd = ADKleinSplashAd(Constants.splashPosid(), "splash_placeholder");
    _splashAd.onClosed = () {
      print("开屏广告关闭了");
      // 在加载失败和关闭回调后关闭广告
      releaseSplashAd();
    };
    _splashAd.onFailed = () {
      print("开屏广告失败了");
      // 在加载失败和关闭回调后关闭广告
      releaseSplashAd();
    };
    _splashAd.onExposed = () {
      print("开屏广告曝光了");
    };
    _splashAd.onSucced = () {
      print("开屏广告成功了");
    };
    _splashAd.onClicked = () {
      print("开屏广告点击了");
    };
    _splashAd.loadAndShow();
  }

  void releaseSplashAd() {
    _splashAd?.release();
    _splashAd = null;
    Navigator.pop(context);
    next();
  }

  void next() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new HomePage()));
  }
}
