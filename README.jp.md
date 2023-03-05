# 昌大学食
[![ko](https://img.shields.io/badge/lang-ko-red.svg)](https://github.com/picel/CWNU_meal/blob/master/README.md)
[![ja](https://img.shields.io/badge/lang-ja-blue.svg)](https://github.com/picel/CWNU_meal/blob/master/README.jp.md)

昌原大學校の食堂情報を提供するアプリです。

## 概要
- Flutter
    - http: 0.13.4
    - html: 0.15.0
    - intl: 0.17.0
    - get: 4.6.1
    - flutter_neumorphic: 3.2.0
    - google_fonts: 2.3.1
    - carousel_slider: 4.0.0
    - flutter_spinkit: 5.1.0
    - url_launcher: 6.0.20
    - animations: 2.0.2
    - in_app_review: 2.0.4
- Android Studio
- BunnyCDN
- Python
- Scrapy

## 動作方法
1. Python/Scrapyを使用して昌原大学の食堂情報をクローリング
2. クローリングしたデータをJSON形式で保存、FTPでBunnyCDNにアップロード
3. Flutter/Dartで開発されたアプリでBunnyCDNにアップロードされたJSONファイルを読み込み、ユーザーに表示

## アプリスクリーンショット
メイン画面|情報画面
:---:|:---:
![メイン画面](https://user-images.githubusercontent.com/30901178/222945932-28bce1e1-6dc1-4427-a438-f8f5f94f530e.jpg)|![情報画面](https://user-images.githubusercontent.com/30901178/222945917-456a2d2c-17de-464c-b78c-45e5835ed5e2.jpg)

寮|サリム館|ボンリム館
:---:|:---:|:---:
![寮](https://user-images.githubusercontent.com/30901178/222945958-1f284047-09b9-44f9-8985-55b6ab1df04c.jpg)|![サリム館](https://user-images.githubusercontent.com/30901178/222945954-d210aead-ad5c-450c-ac49-a8d6da9230b9.jpg)|![ボンリム館](https://user-images.githubusercontent.com/30901178/222945957-5cc10ef5-2b88-4935-b2f3-af4c7932cc74.jpg)

## アプリダウンロード
- [ダウンロード案内ページ](https://cwnumeal.ivis.dev/#/)
- [Google Play](https://play.google.com/store/apps/details?id=com.picel.cwnumeal)
    - [beta](https://play.google.com/apps/testing/com.picel.cwnumeal)
- [App Store](https://apps.apple.com/kr/app/%EC%B0%BD%EB%8C%80%ED%95%99%EC%8B%9D/id1606061004?l=en)