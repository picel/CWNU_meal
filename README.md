# 창대학식
[![ko](https://img.shields.io/badge/lang-ko-red.svg)](https://github.com/picel/CWNU_meal/blob/master/README.md)
[![ja](https://img.shields.io/badge/lang-ja-blue.svg)](https://github.com/picel/CWNU_meal/blob/master/README.jp.md)

창원대학교 학식 정보를 쉽게 알 수 있는 앱

## 개발 환경
- Flutter
    - http
    - html
    - intl
    - get
    - flutter_neumorphic
    - google_fonts
    - carousel_slider
    - flutter_spinkit
    - url_launcher
    - animations
    - in_app_review
    - shared_preferences
    - provider: latest
- VSCode
- BunnyCDN
- Python
    - BeautifulSoup4
    - FTPLib

## 동작 방식
1. Python/Scrapy를 이용하여 창원대학교 학식 정보를 크롤링
2. 크롤링한 데이터를 JSON 형식으로 저장, FTP로 BunnyCDN에 업로드
3. Flutter/Dart로 개발된 앱에서 BunnyCDN에 업로드된 JSON 파일을 불러와서 사용자에게 보여줌

## 앱 스크린샷
메인 화면|설정 화면|설정 화면(다크 모드)
:---:|:---:|:---:
![메인 화면](https://github.com/picel/CWNU_meal/assets/30901178/ef69a2d8-c3bc-4781-aa4d-8824354108be)|![정보 화면](https://github.com/picel/CWNU_meal/assets/30901178/6596e968-c0dd-47cd-849b-73f644cd25b7)|![정보 화면(다크 모드)](https://github.com/picel/CWNU_meal/assets/30901178/ce2e6752-fb51-4929-94df-fa6740c4d1e0)

기숙사|사림관|봉림관
:---:|:---:|:---:
![기숙사](https://github.com/picel/CWNU_meal/assets/30901178/c8070f96-fc51-4df1-aace-13fe31f827d6)|![사림관](https://github.com/picel/CWNU_meal/assets/30901178/73d7f9d1-10f5-464c-a048-930a6d4546a3)|![봉림관](https://github.com/picel/CWNU_meal/assets/30901178/03bb150e-2998-4e53-826e-f98d51d58f56)

## 앱 다운로드
- [다운로드 안내 페이지](https://cwnumeal.ivis.dev/#/)
- [Google Play](https://play.google.com/store/apps/details?id=com.picel.cwnumeal)
    - [beta](https://play.google.com/apps/testing/com.picel.cwnumeal)
- [App Store](https://apps.apple.com/kr/app/%EC%B0%BD%EB%8C%80%ED%95%99%EC%8B%9D/id1606061004?l=en)
- [Web](https://flutter.picel.net/cwnumeal)
