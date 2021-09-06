import 'package:ad_klein_flutter_sdk/ad_klein_ad.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

class RewardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RewardState();
}

class _RewardState extends State<RewardPage> {
  var _rewardAd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reward"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                showRewardAd();
              },
              child: Text("加载广告"),
            ),
          ],
        ),
      ),
    );
  }

  void showRewardAd() {
    if (_rewardAd != null) {
      return;
    }
    _rewardAd = ADKleinRewardAd(posId: Constants.rewardPosid());
    _rewardAd.onClicked = () {
      print("激励视频广告关闭了");
    };
    _rewardAd.onFailed = () {
      print("激励视频广告失败了");
      releaseRewardAd();
    };
    _rewardAd.onExposed = () {
      print("激励视频广告曝光了");
    };
    _rewardAd.onSucced = () {
      print("激励视频广告成功了");
      playRewardAd();
    };
    _rewardAd.onClicked = () {
      print("激励视频广告点击了");
    };
    _rewardAd.onRewarded = () {
      print("激励视频广告激励达成");
    };
    _rewardAd.onClosed = () {
      print("激励视频广告关闭");
      releaseRewardAd();
    };
    _rewardAd.load();
  }

  void releaseRewardAd() {
    _rewardAd?.release();
    _rewardAd = null;
  }

  void playRewardAd() {
    _rewardAd.show();
  }

  @override
  void dispose() {
    releaseRewardAd();
    super.dispose();
  }
}
