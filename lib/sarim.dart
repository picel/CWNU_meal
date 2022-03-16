import 'dart:convert';

import 'package:cwnumeal/navDrawer.dart';
import 'package:cwnumeal/sarim_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(
    const MaterialApp(
        title: "창대학식",
        debugShowCheckedModeBanner: false,
        home: Sarim())
);

class Sarim extends StatefulWidget {
  const Sarim({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Sarim> {
  List result = List.filled(5, '', growable: false);
  String DOW = "오늘";
  int i = 0;
  bool isLoading = false;

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/sarim.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var dataset = jsonDecode(jsonData);

      var date = DateTime.now();
      String today = DateFormat('E').format(date);

      setState(() {
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
        }
        if (DOW == "주말"){
          result = List.filled(5, '주말은 문 닫아용', growable: false);
        } else{
          for(int j = 0; j < 4; j++){
            result[j] = dataset[i.toString()][j];
          }
        }
        result[4] = dataset["5"];
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
    double boxHeight = MediaQuery.of(context).size.height * 0.14;
    double buttonWid = MediaQuery.of(context).size.width * 0.8;
    double buttonHei = MediaQuery.of(context).size.height * 0.075;
    double btnFont = MediaQuery.of(context).size.height * 0.02;
    double fontSize = MediaQuery.of(context).size.height * 0.02;
    double titleFontSize = MediaQuery.of(context).size.height * 0.021;
    double boxpadding = MediaQuery.of(context).size.height * 0.02;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff153c85),
            title: Text('$DOW의 사림관 식단'),
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
                Tab(child: Text("사림관")),
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
                                  MaterialPageRoute(builder: (context) => const sarim_all()));
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
                              Text("양식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[0],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
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
                              Text("한식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[1],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
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
                              Text("정식",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[2],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
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
                              Text("분식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[3],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01
                      ),
                      Container(
                          child: Text(result[4],
                              style: TextStyle(
                                fontSize: fontSize,
                              )
                          )
                      )
                    ],
                  )
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
  const url = 'http://changwon.ac.kr/kor/di/diView/dietView.do?mi=10199&kind=S';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}