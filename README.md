# AdKleinSDK Flutter SDK——接入文档

## 1.1概述

尊敬的开发者朋友，欢迎您使用AdKlein广告聚合SDK。通过本文档，您可以在几分钟之内轻松完成广告的集成过程。

操作系统： iOS 9.0 及以上版本，Android 4.4 及以上版本，

运行设备：iPhone （iPad上可能部分广告正常展示，但是存在填充很低或者平台不支持等问题，建议不要在iPad上展示广告），Android

## 2.1 SDK导入

首先需要导入主SDK

```dart
dependencies:
  ad_klein_flutter_sdk: {library version}
```
然后需要导入各平台SDK，

### 2.1.1 iOS在项目的podfile中增加如下内容，可以根据实际需要选择性导入平台

```ruby
pod 'AdKleinSDK/AdKleinSDKPlatforms/GDT'        # 优量汇(推荐)
pod 'AdKleinSDK/AdKleinSDKPlatforms/CSJ'        # 穿山甲(推荐)
pod 'AdKleinSDK/AdKleinSDKPlatforms/Mobius'     # 莫比乌斯(推荐)
#pod 'AdKleinSDK/AdKleinSDKPlatforms/BaiDu'      # 百青藤(可选)
#pod 'AdKleinSDK/AdKleinSDKPlatforms/Google'    # Admob(可选)
#pod 'AdKleinSDK/AdKleinSDKPlatforms/Smaato'    # Smaato(可选)
```
注意： 接入Google的Admob广告请务必参考5.1.1在Info.plist中添加GADApplicationIdentifier信息。

### 2.1.2 Android在项目中增加如下内容，可以根据实际需要选择性导入平台

#### 2.1.2.1. 在android根目录build.gradle中添加klein仓库
```java
allprojects {
    repositories {
        ...
        google()
        jcenter()
        mavenCentral()
        // 添加以下仓库地址
        // AdKlein远程仓库 credentials：访客模式
        maven {
                    credentials {
                        username '612da771fa25fa3e244cf7d8'
                        password '488L5cNZL50n'
                    }
                    url 'https://packages.aliyun.com/maven/repository/2133520-release-i5MW1M/'
                }
        // 如果添加了smaato广告,需要添加smaato的远程仓库依赖
        maven { url "https://s3.amazonaws.com/smaato-sdk-releases/" }
        // 如果添加了华为联盟广告，需要添加华为联盟的远程仓库依赖
        maven { url 'http://developer.huawei.com/repo/' }
    }
}
```
#### 2.1.2.2. OAID支持
导入安全联盟的OAID支持库 oaid_sdk_1.0.23.aar，可在Demo的libs目录下找到，强烈建议使用和Demo中一样版本的OAID库（包括项目中已存在的依赖的oaid版本）；
将Demo中assets文件夹下的supplierconfig.json文件复制到自己的assets目录下并按照supplierconfig.json文件中的说明进行OAID的 AppId 配置，supplierconfig.json文件名不可修改；

#### 2.1.2.3. 添加AdKleinSDK和需要的AdapterSdk

将广告所需要的依赖集成进去，AdapterSdk可根据接入平台情况进行选择接入。

```java
dependencies {
    // 至少接入一个平台，但不推荐全部接入。如果不清楚需要哪些平台可以咨询媒介。

    // OAID(必须)
    implementation(name: 'msa_mdid_1.0.23', ext: 'aar')

    // adKleinSdk(必须)
    implementation 'com.squareup.okhttp3:okhttp:3.12.1'
    implementation 'com.iusmob.adklein.ad:core:3.1.1'
    
    // 莫比乌斯，推荐接入(需要gson和okhttp支持)
    implementation 'com.iusmob.adklein.ad:mobius:2.1.3'
    implementation 'com.google.code.gson:gson:2.8.5'
    
    // 头条，推荐接入
    implementation 'com.iusmob.adklein.ad.adapter:toutiao:2.1.1'
    
    // 广点通，推荐接入
    implementation 'com.iusmob.adklein.ad.adapter:gdt:2.1.1'
    
    // 快手AdapterSDK，可选的
    implementation 'com.iusmob.adklein.ad.adapter:ks:2.1.1'
    
    // 百度AdapterSDK，可选的
    implementation 'com.iusmob.adklein.ad.adapter:baidu:2.1.1'
    
    // AdMobAdapterSdk，可选的（海外市场）
    implementation 'com.iusmob.adklein.ad.adapter:am:2.1.1'
    
    // SmMobAdapterSdk，可选的（海外市场）
    implementation 'com.iusmob.adklein.ad.adapter:sm:2.1.1'
    
    //华为AdapterSDK，可选的
    implementation 'com.iusmob.adklein.ad.adapter:hwpps:2.1.1'
    
    //米盟AdapterSDK，可选的（还需要gson和glide支持）
    implementation 'com.iusmob.adklein.ad.adapter:mimo:2.1.1'
}
```
## 3.1 工程环境配置

### 3.1.1 IOS 工程环境配置

#### 3.1.1.1. info.plist 添加支持 Http访问字段

```
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

#### 3.1.1.2. Info.plist推荐设置白名单，可提高广告收益

```
<key>LSApplicationQueriesSchemes</key>
<array>
  <!-- 电商 -->
  <string>taobao</string><!-- 淘宝  -->
  <string>tmall</string><!-- 天猫  -->
  <string>jdlogin</string><!-- 京东  -->
  <string>pinduoduo</string> <!-- 拼多多  -->
  <string>kaola</string> <!-- 网易考拉  -->
  <string>yanxuan</string> <!-- 网易严选  -->
  <string>vipshop</string> <!-- 唯品会  -->
  <string>suning</string> <!-- 苏宁  -->
  <string>mishopv1</string> <!-- 小米商城 -->
  <string>wireless1688</string> <!-- 阿里巴巴 -->

  <!-- 社交、社区-->
  <string>weibo</string><!-- 微博 -->
  <string>zhihu</string><!-- 知乎 -->
  <string>xhsdiscover</string><!-- 小红书 -->
  <string>momochat</string><!-- 陌陌 -->
  <string>blued</string><!-- blued -->
  <string>mqzone</string><!-- QQ空间 -->
  <string>mqq</string><!-- QQ -->
  <string>tantanapp</string><!-- 探探 -->
  <string>huputiyu</string><!-- 虎扑 -->
  <string>com.baidu.tieba</string> <!-- 贴吧  -->
  <string>tianya</string> <!-- 天涯社区  -->
  <string>douban</string> <!-- 豆瓣 -->
  <string>jike</string> <!-- 即刻 -->

  <!-- 短视频 -->
  <string>snssdk1128</string> <!-- 抖音 -->
  <string>snssdk1112</string> <!-- 火山 -->
  <string>snssdk32</string> <!-- 西瓜视频 -->
  <string>gifshow</string> <!-- 快手 -->

  <!-- 视频/直播 -->
  <string>tenvideo</string> <!-- 腾讯视频  -->
  <string>youku</string> <!-- 优酷  -->
  <string>bilibili</string> <!-- B站  -->
  <string>imgotv</string> <!-- 芒果TV  -->
  <string>qiyi-iphone</string> <!-- 爱奇艺  -->
  <string>hanju</string> <!-- 韩剧TV  -->
  <string>douyutv</string> <!-- 斗鱼  -->
  <string>yykiwi</string> <!-- 虎牙  -->

  <!-- 图片处理  -->
  <string>mtxx.open</string> <!-- 美图秀秀  -->
  <string>faceu</string> <!-- faceu国内  -->
  <string>ulike</string> <!-- 轻颜国内 -->

  <!-- 资讯 -->
  <string>snssdk141</string> <!-- 今日头条  -->
  <string>newsapp</string> <!-- 网易新闻  -->
  <string>qqnews</string> <!-- 腾讯新闻  -->
  <string>iting</string> <!-- 喜马拉雅 -->
  <string>weread</string> <!-- 微信读书 -->
  <string>jianshu</string> <!-- 简书 -->
  <string>igetApp</string> <!-- 得到 -->
  <string>kuaikan</string> <!-- 快看漫画 -->

  <!-- 财经 -->
  <string>sinanews</string> <!-- 新浪财经  -->
  <string>amihexin</string> <!-- 同花顺炒股 -->

  <!-- 音乐 -->
  <string>orpheus</string> <!-- 网易云音乐  -->
  <string>qqmusic</string> <!-- qq音乐  -->
  <string>kugouURL</string> <!-- 酷狗  -->
  <string>qmkege</string> <!-- 全民K歌 -->
  <string>changba</string> <!-- 唱吧  -->

  <!-- 工具 -->
  <string>iosamap</string> <!-- 高德地图  -->
  <string>baidumap</string> <!-- 百度地图   -->
  <string>baiduyun</string> <!-- 百度网盘  -->
  <string>rm434209233MojiWeather</string> <!-- 墨迹天气  -->

  <!-- 办公 -->
  <string>wxwork</string> <!-- 企业微信  -->
  <string>dingtalk</string> <!-- 钉钉 -->

  <!-- 生活 -->
  <string>imeituan</string> <!-- 美团  -->
  <string>dianping</string> <!-- 点评  -->
  <string>cainiao</string> <!-- 菜鸟裹裹  -->
  <string>wbmain</string> <!--  58同城 -->
  <string>mihome</string> <!--  米家 -->

  <!-- 美食佳饮  -->
  <string>xcfapp</string> <!-- 下厨房  -->
  <string>sbuxcn</string> <!-- 星巴克中国  -->
  <string>meituanwaimai</string> <!-- 美团外卖  -->

  <!-- 运动健康  -->
  <string>fb370547106731052</string> <!-- 小米运动  -->
  <string>meetyou.linggan</string> <!-- 美柚  -->
  <string>babytree</string> <!-- 宝宝树  -->
  <string>keep</string> <!-- keep  -->

  <!-- 旅行  -->
  <string>CtripWireless</string> <!-- 携程  -->
  <string>diditaxi</string> <!-- 滴滴  -->
  <string>taobaotravel</string> <!-- 飞猪  -->
  <string>travelguide</string> <!-- 马蜂窝  -->

  <!-- 游戏 -->
  <string>tencent1104466820</string> <!-- 王者荣耀  -->
  <string>tencent100689805</string> <!-- 天天爱消除  -->
  <string>tencent382</string> <!-- QQ斗地主  -->
</array>
```
### 3.1.2 Android 工程环境配置

#### 3.1.2.1 权限配置
```java
<!-- 广告必须的权限 -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />

<!-- 广点通广告必须的权限 -->
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- 影响广告填充，强烈建议的权限 -->
<uses-permission android:name="android.permission.READ_PHONE_STATE" />

<!-- 为了提高广告收益，建议设置的权限 -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<!-- 如果有视频相关的广告播放请务必添加-->
<uses-permission android:name="android.permission.WAKE_LOCK" />
```
#### 3.1.2.2 FileProvider配置
适配Anroid7.0以及以上，请在AndroidManifest中添加如下代码：
如果支持库是support
```java
<provider
      android:name="android.support.v4.content.FileProvider"
    android:authorities="${applicationId}.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
            android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/adklein_file_paths" />
</provider>
```
如果支持库为androidx
```java
<provider
      android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
            android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/adklein_file_paths" />
</provider>
```
在res/xml目录下(如果xml目录不存在需要手动创建)，新建xml文件adklein_file_paths，在该文件中加入如下配置，如果存在相同android:authorities的provider，请将paths标签中的路劲配置到自己的xml文件中：
```java
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-path name="external_path" path="." />
    <external-files-path name="external_files_path" path="." />
</paths>
```

#### 3.1.2.3 网络配置 
需要在 AndroidManifest.xml 添加依赖声明uses-library android:name="org.apache.http.legacy" android:required="false"， 且 application标签中添加 android:usesCleartextTraffic="true"，适配网络http请求，否则 SDK可能无法正常工作，接入代码示例如下：
```java
<application
    android:name=".MyApplication"
        ... ...
    android:usesCleartextTraffic="true">

    <uses-library
        android:name="org.apache.http.legacy"
        android:required="false" />
    ... ...
</application>
```
#### 3.1.2.4 混淆配置
可以参考demo中proguard-rules.pro相关配置

## 3.2 iOS14适配

由于iOS14中对于权限和隐私内容有一定程度的修改，而且和广告业务关系较大，请按照如下步骤适配，如果未适配。不会导致运行异常或者崩溃等情况，但是会一定程度上影响广告收入。详情请访问https://developer.apple.com/documentation/apptrackingtransparency。

1. 应用编译环境升级至 Xcode 12.0 及以上版本；
2. 升级ADKleinSDK 3.0.8及以上版本；
3. 设置SKAdNetwork和IDFA权限

### 3.2.1 获取App Tracking Transparency授权（弹窗授权获取IDFA）

从 iOS 14 开始，在应用程序调用 App Tracking Transparency 向用户提跟踪授权请求之前，IDFA 将不可用。

1. 更新 Info.plist，添加 NSUserTrackingUsageDescription 字段和自定义文案描述。

   弹窗小字文案建议：

   - `获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`
   - `获取IDFA标记权限向您提供更优质、安全的个性化服务及内容；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`

```
<key>NSUserTrackingUsageDescription</key>
<string>获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭</string>
```

1. 向用户申请权限。

objc
```
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
    [self requestAd];
  }];
}
```

swift
```
import AppTrackingTransparency

if #available(iOS 14.5, *) {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        })
    } else {
    }
```
### 3.2.2 SKAdNetwork

SKAdNetwork 是接收iOS端营销推广活动归因数据的一种方法。

1. 将下列SKAdNetwork ID 添加到 info.plist 中，以保证 SKAdNetwork 的正确运行。根据对接平台添加相应SKAdNetworkID，若无对接平台SKNetworkID则无需添加。

```
<key>SKAdNetworkItems</key>
<array>
<!-- 穿山甲  -->
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>238da6jt44.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>x2jnk7ly8j.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>22mmun2rn5.skadnetwork</string>
  </dict>
  <!-- 优量汇（广点通）  -->
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>f7s53z58qe.skadnetwork</string>
  </dict>
  <!-- Admob（谷歌广告）） -->
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>cstr6suwn9.skadnetwork</string>
  </dict>
</array>
```

## 4.1 主SDK初始化

```dart
AdKleinFlutterSdk.initSdk(appid: "appid");
```

## 4.2 开屏广告
```dart
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  var _splashAd;

  @override
  Widget build(BuildContext context) {
    showSplashAd();
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash"),
      ),
      body: Center(),
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
  }

  @override
  void dispose() {
    releaseSplashAd();
    super.dispose();
  }
}
```
## 4.3 横幅广告（banner）
```dart
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

```

## 4.4 全屏视频广告
```dart
class FullScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FullScreenState();
}

class FullScreenState extends State<FullScreenPage> {
  var _fullScreenVodAd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FullScreenVodAd"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                showFullScreenVodAd();
              },
              child: Text("加载广告"),
            ),
          ],
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
```
## 4.5 插屏广告
```dart
class InterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InterState();
}

class _InterState extends State<InterPage> {
  var _interAd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intertitial"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                showInterAd();
              },
              child: Text("加载广告"),
            ),
          ],
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

```
## 4.6 信息流广告
```dart
class NativePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NativeState();
}

class NativeState extends State<NativePage> {
  var _nativeAd;

  List<dynamic> _items = List.generate(10, (i) => i);
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
                    child: Text("Cell", style: TextStyle(fontSize: 75)));
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

```
## 4.7 激励视频广告
```dart
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

```

## 更新日志

| 版本号  |    日期    | 更新日志                                                     |
| ------- | :--------: | ------------------------------------------------------------ |
| v0.0.2  | 2021-09-8 | 解决ios重复导入导致的冲突         |
| v0.0.1  | 2021-09-6 | 0.0.1正式发布。         |
