import 'dart:convert';

import 'package:cwnumeal/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dorm_all.dart';

void main() => runApp(
    MaterialApp(
        title: "창대학식",
        debugShowCheckedModeBanner: false,
        home: MyApp(),
        theme: ThemeData(
          primaryColor: const Color(0xff153c85),
        )
    )
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List result = List.filled(22, '', growable: false);
  bool isLoading = false;
  String DOW = "오늘";
  String lcTime = "(11:30 ~ 13:30)";
  String bfTime = "(07:30 ~ 9:30)";
  String dnTime = "(17:00 ~ 19:00)";

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/dorm.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var dataset = jsonDecode(jsonData);

      var date = DateTime.now();
      String today = DateFormat('E').format(date);

      setState(() {
        int i = 0;
        switch(today) {
          case 'Mon':
            i = 0;
            DOW = "월요일";
            break;
          case 'Tue':
            i = 1;
            DOW = "화요일";
            break;
          case 'Wed':
            i = 2;
            DOW = "수요일";
            break;
          case 'Thu':
            i = 3;
            DOW = "목요일";
            break;
          case 'Fri':
            i = 4;
            DOW = "금요일";
            break;
          case 'Sat':
            i = 5;
            DOW = "토요일";
            break;
          case 'Sun':
            i = 6;
            DOW = "일요일";
            break;
        }
        int k = 0;
        for(int j = 0; j < 3; j++){
          if(dataset[i.toString()][j] == '') result[k] = '영업 중단';
          else result[k] = dataset[i.toString()][j];
          k++;
        }
        result[21] = dataset["7"];
        isLoading = false;
      });
    } catch (e) {
      print('error!');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width * 0.7;
    double boxHeight = MediaQuery.of(context).size.height * 0.2;
    double buttonWid = MediaQuery.of(context).size.width * 0.8;
    double buttonHei = MediaQuery.of(context).size.height * 0.075;
    double btnFont = MediaQuery.of(context).size.height * 0.02;
    double fontSize = MediaQuery.of(context).size.height * 0.017;
    double titleFontSize = MediaQuery.of(context).size.height * 0.02;
    double boxpadding = MediaQuery.of(context).size.height * 0.02;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff153c85),
            title: Text('$DOW의 기숙사 식단'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  fetchData();
                },
              ),
              IconButton(
                  onPressed: _launchURL,
                  icon: const Icon(Icons.public)
              )
            ],
          ),
          drawer: navDrawer(),
          bottomNavigationBar: SafeArea(
            child: const TabBar(
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
              labelColor: Color(0xff153c85),
              tabs: [
                Tab(child: Text("기숙사"))
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            child: TabBarView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? SpinKitThreeBounce(
                    color: const Color(0xff153c85),
                    size: 30.0,
                  )
                      : Column(
                    children: [
                      Container(
                          height: buttonHei,
                          width: buttonWid,
                          alignment: Alignment.topRight,
                          child: CupertinoButton(
                            child: Text('전체 식단 보기',
                              style: TextStyle(
                                color: const Color(0xff153c85),
                                fontSize: btnFont,
                              ),),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const dorm_all()),
                              );
                            },
                          )
                      ),
                      Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: EdgeInsets.all(boxpadding),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    offset: Offset(0, 1))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("아침 $bfTime",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.005
                              ),
                              Text(result[0],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: EdgeInsets.all(boxpadding),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    offset: Offset(0, 1))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("점심 $lcTime",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.005
                              ),
                              Text(result[1],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: EdgeInsets.all(boxpadding),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    offset: Offset(0, 1))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("저녁 $dnTime",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.005
                              ),
                              Text(result[2],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005
                      ),
                      Container(
                          child: Text(result[21],
                            style: TextStyle(
                              fontSize: fontSize,
                            )
                          )
                      )
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://www.changwon.ac.kr/dorm/na/ntt/selectNttList.do?mi=10079&bbsId=2918';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}