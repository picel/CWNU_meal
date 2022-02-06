import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BonglimDBok())
);

class BonglimDBok extends StatefulWidget {
  const BonglimDBok({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<BonglimDBok> {
  List result = List.filled(21, '', growable: false);

  bool isLoading = false;

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/bonglim.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var dataset = jsonDecode(jsonData);
      setState(() {
        int k = 0;
        for(int i = 0; i < 5; i++){
          for(int j = 2; j < 5; j++){
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
    double halfBoxWidth = MediaQuery.of(context).size.width * 0.33;
    double boxHeight = MediaQuery.of(context).size.height * 0.33;
    double buttonWid = MediaQuery.of(context).size.width * 0.8;
    double buttonHei = MediaQuery.of(context).size.height * 0.07;
    double fontSize = MediaQuery.of(context).size.height * 0.015;
    double titleFontSize = MediaQuery.of(context).size.height * 0.022;
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
            title: const Text('다복솔 전체 식단'),
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
            padding: const EdgeInsets.all(20.0),
            child: TabBarView(children: [
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? const SpinKitThreeBounce(
                  color: Color(0xff153c85),
                  size: 30.0,
                )
                    : Column(
                  children: [
                    Container(
                      height: buttonHei,
                      width: buttonWid,
                      alignment: Alignment.topRight,
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
                                Text("점심",
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
                                Text(result[2],
                                    style: TextStyle(
                                      fontSize: fontSize,)),
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
                            Text("저녁",
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
                  ],
                )
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
                                  Text("점심",
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
                                  Text(result[5],
                                      style: TextStyle(
                                        fontSize: fontSize,)),
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
                              Text("저녁",
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
                    ],
                  )
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
                                  Text("점심",
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
                                  Text(result[8],
                                      style: TextStyle(
                                        fontSize: fontSize,)),
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
                              Text("저녁",
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
                  )
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
                                  Text("점심",
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
                                  Text(result[11],
                                      style: TextStyle(
                                        fontSize: fontSize,)),
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
                              Text("저녁",
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
                    ],
                  )
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
                                  Text("점심",
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
                                  Text(result[14],
                                      style: TextStyle(
                                        fontSize: fontSize,)),
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
                              Text("저녁",
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
