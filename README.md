# 창대학식

창원대학교 학식 정보를 쉽게 알 수 있는 앱

## 개발 환경
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

## 동작 방식
1. Python/Scrapy를 이용하여 창원대학교 학식 정보를 크롤링
2. 크롤링한 데이터를 JSON 형식으로 저장, FTP로 BunnyCDN에 업로드
3. Flutter/Dart로 개발된 앱에서 BunnyCDN에 업로드된 JSON 파일을 불러와서 사용자에게 보여줌

## 앱 스크린샷
메인 화면|정보 화면
:---:|:---:
![메인 화면](https://user-images.githubusercontent.com/30901178/222945932-28bce1e1-6dc1-4427-a438-f8f5f94f530e.jpg)|![정보 화면](https://user-images.githubusercontent.com/30901178/222945917-456a2d2c-17de-464c-b78c-45e5835ed5e2.jpg)

기숙사|사림관|봉림관
:---:|:---:|:---:
![기숙사](https://user-images.githubusercontent.com/30901178/222945958-1f284047-09b9-44f9-8985-55b6ab1df04c.jpg)|![사림관](https://user-images.githubusercontent.com/30901178/222945954-d210aead-ad5c-450c-ac49-a8d6da9230b9.jpg)|![봉림관](https://user-images.githubusercontent.com/30901178/222945957-5cc10ef5-2b88-4935-b2f3-af4c7932cc74.jpg)

## 앱 다운로드
- [다운로드 안내 페이지](https://cwnumeal.ivis.dev/#/)
- [Google Play](https://play.google.com/store/apps/details?id=com.picel.cwnumeal)
    - [beta](https://play.google.com/apps/testing/com.picel.cwnumeal)
- [App Store](https://apps.apple.com/kr/app/%EC%B0%BD%EB%8C%80%ED%95%99%EC%8B%9D/id1606061004?l=en)
- [Web](https://flutter.picel.net/cwnumeal)