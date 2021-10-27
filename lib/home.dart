import 'package:flutter/material.dart';

import 'banner.dart';
import 'fullscreen.dart';
import 'inter.dart';
import 'native.dart';
import 'reward.dart';
import 'splash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  static const listData = [
    "SplashAd(开屏广告)",
    "Native(信息流广告)",
    "Banner(横幅广告)",
    "Inter(插屏广告)",
    "Reward(激励视频广告)",
    "fullscreenVod(全屏视频广告)"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('ADKlein广告Demo_Flutter'),
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
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    var widget;
                    switch (index) {
                      case 0:
                        widget = SplashPage();
                        break;
                      case 1:
                        widget = NativePage();
                        break;
                      case 2:
                        widget = BannerPage();
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
        ));
  }
}
