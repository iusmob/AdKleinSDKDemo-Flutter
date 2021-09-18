import 'package:ad_klein_flutter_sdk/ad_klein_ad.dart';
import 'package:ad_klein_flutter_sdk/ad_klein_base.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

class NativePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NativeState();
}

class NativeState extends State<NativePage> {
  var _nativeAd;

  List<dynamic> _items = List.generate(5, (i) => i);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getAdData();
      }
    });
  }

  _getAdData() async {
    _nativeAd.load();
  }

  void createNativeAd(BuildContext context) {
    if (_nativeAd == null) {
      MediaQueryData queryData = MediaQuery.of(context);
      var width = queryData.size.width;
      _nativeAd =
          ADKleinFlutterNativeAd(posId: Constants.nativePosid(), width: width);
      _nativeAd.onReceived = (ADKleinFlutterNativeAdView adView) {
        setState(() {
          var adWidget = ADKleinWidget(adView: adView);
          adView.onClosed = () {
            setState(() {
              _items.remove(adWidget);
              adView.release();
            });
          };
          adView.onExposed = () {};

          _items.add(adWidget);
          _items.addAll(List.generate(1, (i) => i));
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    createNativeAd(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Native"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _items.length,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              final item = _items[index];
              if (item is Widget) {
                return item;
              } else {
                return Container(
                    width: 300,
                    height: 150,
                    child: Center(
                        child: Text("Normal Data",
                            style: TextStyle(fontSize: 45))));
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    for (var item in _items) {
      if (item is ADKleinFlutterNativeAdView) {
        item.release();
      }
    }
    _nativeAd.release();
    _nativeAd = null;
    super.dispose();
  }
}
