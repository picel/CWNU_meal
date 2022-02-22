import 'dart:convert';

import 'package:cwnumeal/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bonglimDBaek_all.dart';
import 'bonglimDBok_all.dart';

void main() => runApp(
    const MaterialApp(
        title: "창대학식",
        debugShowCheckedModeBanner: false,
        home: Bonglim())
);

class Bonglim extends StatefulWidget {
  const Bonglim({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Bonglim> {
  List result = List.filled(21, '', growable: false);
  String DOW = "주말";
  int i = 0;
  bool isLoading = false;

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/bonglim.json'));
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
          result = List.filled(21, '주말은 문 닫아용', growable: false);
        } else{
          for(int j = 0; j < 5; j++){
            result[j] = dataset[i.toString()][j];
          }
        }
        result[5] = dataset["5"];
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
    double halfBoxWidth = MediaQuery.of(context).size.width * 0.33;
    double boxHeight = MediaQuery.of(context).size.height * 0.3;
    double buttonWid = MediaQuery.of(context).size.width * 0.8;
    double buttonHei = MediaQuery.of(context).size.height * 0.075;
    double btnFont = MediaQuery.of(context).size.height * 0.02;
    double dbaekFontSize = MediaQuery.of(context).size.height * 0.018;
    double dbokFontSize = MediaQuery.of(context).size.height * 0.015;
    double titleFontSize = MediaQuery.of(context).size.height * 0.021;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff153c85),
            title: Text('$DOW의 봉림관 식단'),
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
                Tab(child: Text("동백홀")),
                Tab(child: Text("다복솔")),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(5.0),
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
                                  MaterialPageRoute(builder: (context) => const BonglimDBaek()));
                            },
                          )
                      ),
                      Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: const EdgeInsets.all(20),
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
                              Text("점심 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[0],
                                  style: TextStyle(
                                    fontSize: dbaekFontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: const EdgeInsets.all(20),
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
                              Text("저녁 (17:00 ~ 18:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[1],
                                  style: TextStyle(
                                    fontSize: dbaekFontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01
                      ),
                      Container(
                        child: Text(result[5],
                            style: TextStyle(
                              fontSize: dbaekFontSize,
                            )
                        )
                      )
                    ],
                  ),
                ],
              ),
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
                                  MaterialPageRoute(builder: (context) => const BonglimDBok()));
                            },
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: boxHeight,
                              width: halfBoxWidth,
                              padding: const EdgeInsets.all(20),
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
                                  Text("점심 (11:30~14:00)",
                                      style: TextStyle(
                                          fontSize: titleFontSize,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01
                                  ),
                                  Text(result[2],
                                      style: TextStyle(
                                        fontSize: dbokFontSize,)),
                                ],
                              )
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04
                          ),
                          Container(
                              height: boxHeight,
                              width: halfBoxWidth,
                              padding: const EdgeInsets.all(20),
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
                                  Text("분식",
                                      style: TextStyle(
                                          fontSize: titleFontSize,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01
                                  ),
                                  Text(result[4],
                                      style: TextStyle(
                                        fontSize: dbokFontSize,)),
                                ],
                              )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                          height: boxHeight,
                          width: boxWidth,
                          padding: const EdgeInsets.all(20),
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
                              Text("저녁 (17:00 ~ 18:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[3],
                                  style: TextStyle(
                                    fontSize: dbokFontSize,)),
                            ],
                          )
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01
                      ),
                      Container(
                          child: Text(result[5],
                              style: TextStyle(
                                fontSize: dbokFontSize,
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
  const url = 'https://www.changwon.ac.kr/kor/di/diView/dietView.do?mi=10198&kind=B';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}