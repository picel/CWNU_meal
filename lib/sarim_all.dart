import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';


void main() => runApp(
    const MaterialApp(
        title: "창대학식",
        debugShowCheckedModeBanner: false,
        home: sarim_all())
);

class sarim_all extends StatefulWidget {
  const sarim_all({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<sarim_all> {
  List result = List.filled(20, '', growable: false);

  bool isLoading = false;

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/sarim.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var dataset = jsonDecode(jsonData);
      setState(() {
        int k = 0;
        for(int i = 0; i < 5; i++){
          for(int j = 0; j < 4; j++){
            result[k] = dataset[i.toString()][j];
            k++;
          }
        }
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
    double boxHeight = MediaQuery.of(context).size.height * 0.15;
    double fontSize = MediaQuery.of(context).size.height * 0.017;
    double titleFontSize = MediaQuery.of(context).size.height * 0.021;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: const Color(0xff153c85),
            title: const Text('사림관 전체 식단'),
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
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("월")),
                Tab(child: Text("화")),
                Tab(child: Text("수")),
                Tab(child: Text("목")),
                Tab(child: Text("금")),
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
                              Text("한식 (11:30 ~ 14:00)",
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
                              Text("양식 (11:30 ~ 14:00)",
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
                              Text("한식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[4],
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
                              Text("양식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[5],
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
                              Text("정식",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[6],
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
                              Text("분식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[7],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
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
                              Text("한식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[8],
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
                              Text("양식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[9],
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
                              Text("정식",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[10],
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
                              Text("분식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[11],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
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
                              Text("한식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[12],
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
                              Text("양식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[13],
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
                              Text("정식",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[14],
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
                              Text("분식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[15],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
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
                              Text("한식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[16],
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
                              Text("양식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[17],
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
                              Text("정식",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[18],
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
                              Text("분식 (11:30 ~ 14:00)",
                                  style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01
                              ),
                              Text(result[19],
                                  style: TextStyle(
                                    fontSize: fontSize,)),
                            ],
                          )
                      ),
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
  const url = 'http://changwon.ac.kr/kor/di/diView/dietView.do?mi=10199&kind=S';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}