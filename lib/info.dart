import 'dart:io' show Platform;

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';

void main() => runApp(
    const NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'neumorphic test',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffe5edf6),
        lightSource: LightSource.topLeft,
      ),
      home: Info(),
    )
);

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    double titleFontSize = MediaQuery.of(context).size.height * 0.022;
    double fontSize = MediaQuery.of(context).size.height * 0.015;
    double boxWidth = MediaQuery.of(context).size.width * 0.6;
    double boxmargin = MediaQuery.of(context).size.height * 0.015;
    double boxpadding = MediaQuery.of(context).size.height * 0.025;
    Color mainColor = const Color(0xff455a64);
    String reviewPlatform = Platform.isIOS ? 'AppStore 리뷰 남기기' : 'Google Play Store 리뷰 남기기';
    return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        appBar: NeumorphicAppBar(
          title: Text('정보',
            style: GoogleFonts.jua(
              textStyle: TextStyle(
                  fontSize: 40,
                  color: mainColor
              ),
            ),
          ),
          centerTitle: true,
          leading: NeumorphicButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              depth: 10,
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: mainColor,
              size: 30,
            ),
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Neumorphic(
                  padding: EdgeInsets.all(boxpadding),
                  margin: EdgeInsets.all(boxmargin),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                    depth: -3,
                  ),
                  child: SizedBox(
                      width: boxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("애플리케이션 버전",
                            style: GoogleFonts.jua(
                              textStyle: TextStyle(
                                  fontSize: titleFontSize,
                                  color: mainColor
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01
                          ),
                          Text('v3.0.0',
                            style: GoogleFonts.ibmPlexSansKr(
                              textStyle: TextStyle(
                                fontSize: fontSize,
                                color: mainColor,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03
                          ),
                          Text("업데이트 날짜",
                            style: GoogleFonts.jua(
                              textStyle: TextStyle(
                                  fontSize: titleFontSize,
                                  color: mainColor
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01
                          ),
                          Text('2020-03-18',
                            style: GoogleFonts.ibmPlexSansKr(
                              textStyle: TextStyle(
                                fontSize: fontSize,
                                color: mainColor,
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                NeumorphicButton(
                  onPressed: _StoreReview,
                  padding: EdgeInsets.all(boxpadding),
                  margin: EdgeInsets.all(boxmargin),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  ),
                  child: SizedBox(
                      width: boxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("응원하기",
                            style: GoogleFonts.jua(
                              textStyle: TextStyle(
                                  fontSize: titleFontSize,
                                  color: mainColor
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01
                          ),
                          Text(reviewPlatform,
                            style: GoogleFonts.ibmPlexSansKr(
                              textStyle: TextStyle(
                                fontSize: fontSize,
                                color: mainColor,
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ]
        )
    );
  }
}

Future<void> _StoreReview() async {
  final InAppReview inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()){
    inAppReview.requestReview();
  } else {
    inAppReview.openStoreListing(
      appStoreId: '1606061004',
    );
  }
}