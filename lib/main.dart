import 'package:ad_klein_demo_flutter/reward.dart';
import 'package:ad_klein_demo_flutter/splash.dart';
import 'package:ad_klein_flutter_sdk/ad_klein_flutter_sdk.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';
import 'banner.dart';
import 'fullscreen.dart';
import 'inter.dart';
import 'native.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    AdKleinFlutterSdk.initSdk(appid: Constants.appKey());
  }

  static const listData = [
    "SplashAd(开屏广告)",
    "Banner(横幅广告)",
    "Native(信息流广告)",
    "Inter(插屏广告)",
    "Reward(激励视频广告)",
    "fullscreenVod(全屏视频广告)"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('ADKleinSDK 广告demo'),
          ),
          body: ListView.builder(
            itemCount: listData.length,
            padding: const EdgeInsets.all(15),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: new BoxDecoration(
                    border: new Border.all(
                      width: 1,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      var widget;
                      switch (index) {
                        case 0:
                          widget = SplashPage();
                          break;
                        case 1:
                          widget = BannerPage();
                          break;
                        case 2:
                          widget = NativePage();
                          break;
                        case 3:
                          widget = InterPage();
                          break;
                        case 4:
                          widget = RewardPage();
                          break;
                        case 5:
                          widget = FullScreenPage();
                          break;
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return widget;
                      }));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(listData[index], textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ));
            },
          )),
    );
  }
}
