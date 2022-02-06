import 'dart:convert';

import 'package:cwnumeal/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'dorm_all.dart';

void main() => runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp())
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List result = List.filled(21, '', growable: false);
  bool isLoading = false;

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
            break;
          case 'Tue':
            i = 1;
            break;
          case 'Wed':
            i = 2;
            break;
          case 'Thu':
            i = 3;
            break;
          case 'Fri':
            i = 4;
            break;
          case 'Sat':
            i = 5;
            break;
          case 'Sun':
            i = 6;
            break;
        }
        int k = 0;
        for(int j = 0; j < 3; j++){
          result[k] = dataset[i.toString()][j];
          k++;
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
    double boxHeight = MediaQuery.of(context).size.height * 0.2;
    double buttonWid = MediaQuery.of(context).size.width * 0.8;
    double buttonHei = MediaQuery.of(context).size.height * 0.07;
    double btnFont = MediaQuery.of(context).size.height * 0.02;
    double fontSize = MediaQuery.of(context).size.height * 0.016;
    double titleFontSize = MediaQuery.of(context).size.height * 0.022;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff153c85),
            title: const Text('오늘의 기숙사 식단'),
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
            padding: const EdgeInsets.all(20.0),
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
                              Text("아침",
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
                              Text("점심",
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
                              Text("저녁",
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
