import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'daBok.dart';
import 'dongBaek.dart';
import 'dorm.dart';
import 'info.dart';
import 'globals.dart';
import 'sarim.dart';

void main() => runApp(
    const NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'neumorphic test',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffe5edf6),
        lightSource: LightSource.topLeft,
        defaultTextColor: Colors.blueGrey,
      ),
      home: MyHomepage(),
    )
);

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomepage> with WidgetsBindingObserver {
  List result = List.filled(8, '', growable: false);
  bool isLoading = false;
  String dormNow = '';
  String bongNow = '';

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        isLoading = true;
      });
      fetchData();
    }
  }

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/dorm.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var dorm = jsonDecode(jsonData);

      http.Response response2 = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/sarim.json'));
      String jsonData2 = utf8.decode(response2.bodyBytes);
      var sarim = jsonDecode(jsonData2);

      http.Response response3 = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/bonglim.json'));
      String jsonData3 = utf8.decode(response3.bodyBytes);
      var bonglim = jsonDecode(jsonData3);

      var date = DateTime.now();
      String today = DateFormat('E').format(date);
      int time = int.parse(DateFormat('HH').format(date)) * 60 + int.parse(DateFormat('mm').format(date));

      setState(() {
        if (today == 'Mon') dayOfWeek = 0;
        else if (today == 'Tue') dayOfWeek = 1;
        else if (today == 'Wed') dayOfWeek = 2;
        else if (today == 'Thu') dayOfWeek = 3;
        else if (today == 'Fri') dayOfWeek = 4;
        else if (today == 'Sat') dayOfWeek = 5;
        else if (today == 'Sun') dayOfWeek = 6;

        int tmr = 0;

        if (dayOfWeek < 6) tmr = dayOfWeek + 1;

        if (dayOfWeek <= 4){
          if (time < 570){ //아침
            result[0] = dorm[dayOfWeek.toString()][0];
            result[5] = bonglim[dayOfWeek.toString()][0];
            result[6] = bonglim[dayOfWeek.toString()][2];
            for (int j = 0; j < 4; j++) result[j + 1] = sarim[dayOfWeek.toString()][j];
            dormNow = '(아침)';
            bongNow = '(점심)';
          } else if (time < 810){ //점심
            result[0] = dorm[dayOfWeek.toString()][1];
            result[5] = bonglim[dayOfWeek.toString()][0];
            result[6] = bonglim[dayOfWeek.toString()][2];
            for (int j = 0; j < 4; j++) result[j + 1] = sarim[dayOfWeek.toString()][j];
            dormNow = '(점심)';
            bongNow = '(점심)';
          } else if (time < 1140){ //저녁
            result[0] = dorm[dayOfWeek.toString()][2];
            result[5] = bonglim[dayOfWeek.toString()][1];
            result[6] = bonglim[dayOfWeek.toString()][3];
            for (int j = 0; j < 4; j++) result[j + 1] = sarim[dayOfWeek.toString()][j];
            dormNow = '(저녁)';
            bongNow = '(저녁)';
          } else {
            result[0] = dorm[tmr.toString()][0];
            if (dayOfWeek == 4) {
              for (int j = 1; j <= 7; j++) result[j] = "주말은 문 닫아용";
            } else {
              result[5] = bonglim[tmr.toString()][0];
              result[6] = bonglim[tmr.toString()][2];
              for (int j = 0; j < 4; j++) result[j + 1] = sarim[tmr.toString()][j];
            }
            dormNow = '(내일 아침)';
            bongNow = '(내일 점심)';
            dayOfWeek = tmr;
          }
          result[7] = bonglim[dayOfWeek.toString()][4];
        } else { //주말
          if (time< 810){ //아점
            result[0] = dorm[dayOfWeek.toString()][1];
            for (int j = 1; j <= 7; j++) result[j] = "주말은 문 닫아용";
            dormNow = '(점심)';
          } else if (time < 1140){ //저녁
            result[0] = dorm[dayOfWeek.toString()][2];
            for (int j = 1; j <= 7; j++) result[j] = "주말은 문 닫아용";
            dormNow = '(저녁)';
          } else { //저녁 이후
            if (dayOfWeek == 5) { //토요일일때
              result[0] = dorm['6'][1];
              for (int j = 1; j <= 7; j++) result[j] = "주말은 문 닫아용";
              dormNow = '(점심)';
            } else {
              for (int i = 0; i <= 7; i++) result[i] = "오늘 밤 12시 업데이트 예정입니다 :3";
            }
          }
        }
        for (int i = 0; i <= 7; i++){
          if (result[i] == '') result[i] = '영업 중단';
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        for (int i = 0; i <= 7; i++) result[i] = '오류 발생';
        isLoading = false;
      });
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double titleFontSize = MediaQuery.of(context).size.height * 0.02;
    double fontSize = MediaQuery.of(context).size.height * 0.0155;
    double dormBoxHeight = MediaQuery.of(context).size.height * 0.258;
    double sarimBoxHeight = MediaQuery.of(context).size.height * 0.225;
    double bonglimBoxHeight = MediaQuery.of(context).size.height * 0.33;
    double boxWidth = MediaQuery.of(context).size.width * 0.6;
    double boxmargin = MediaQuery.of(context).size.height * 0.012;
    double boxpadding = MediaQuery.of(context).size.height * 0.02;
    double viewportFraction = 0.78;
    Color mainColor = const Color(0xff455a64);
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(
        title: Text('창대학식',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Info()),
              );
            },
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.flat,
              depth: 10,
            ),
            child: Icon(
              Icons.question_mark_rounded,
              color: mainColor,
              size: 30,
            ),
          ),
        actions: [
          NeumorphicButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                fetchData();
              },
              style: const NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                depth: 10,
              ),
            child: Icon(
              Icons.refresh_rounded,
              color: mainColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading ? SpinKitSquareCircle(
            color: mainColor,
            size: 30.0,
          ) : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    height: dormBoxHeight,
                    viewportFraction: viewportFraction,
                  ),
                  items: [
                    NeumorphicButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Dorm()),
                        );
                      },
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
                              Text("기숙사 $dormNow",
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
                              Text(result[0],
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
                CarouselSlider(
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: sarimBoxHeight,
                      viewportFraction: viewportFraction
                  ),
                  items: [
                    NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Sarim()),
                          );
                        },
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
                                Text("사림관 양식",
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
                                Text(result[1],
                                  style: GoogleFonts.ibmPlexSansKr(
                                    textStyle: TextStyle(
                                      fontSize: fontSize,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                    NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Sarim()),
                          );
                        },
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
                                Text("사림관 한식",
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
                                Text(result[2],
                                  style: GoogleFonts.ibmPlexSansKr(
                                    textStyle: TextStyle(
                                      fontSize: fontSize,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                    NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Sarim()),
                          );
                        },
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
                                Text("사림관 정식",
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
                                Text(result[3],
                                  style: GoogleFonts.ibmPlexSansKr(
                                    textStyle: TextStyle(
                                      fontSize: fontSize,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                    NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Sarim()),
                          );
                        },
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
                                Text("사림관 분식(라면)",
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
                                Text(result[4],
                                  style: GoogleFonts.ibmPlexSansKr(
                                    textStyle: TextStyle(
                                      fontSize: fontSize,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                  ],
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    height: bonglimBoxHeight,
                    viewportFraction: viewportFraction,
                  ),
                  items: [
                    NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DBaek()),
                          );
                        },
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
                                Text("봉림관 동백홀 $bongNow",
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
                                Text(result[5],
                                  style: GoogleFonts.ibmPlexSansKr(
                                    textStyle: TextStyle(
                                      fontSize: fontSize,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                    NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DBok()),
                          );
                        },
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
                                Text("봉림관 다복솔 $bongNow",
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
                                Text(result[6],
                                  style: GoogleFonts.ibmPlexSansKr(
                                    textStyle: TextStyle(
                                      fontSize: fontSize,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                    NeumorphicButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DBok()),
                          );
                        },
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
                                Text("봉림관 다복솔 분식 $bongNow",
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
                                Text(result[7],
                                  style: GoogleFonts.ibmPlexSansKr(
                                    textStyle: TextStyle(
                                      fontSize: fontSize,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: titleFontSize,
                )
              ],
            )
        ]
      ),
    );
  }
}