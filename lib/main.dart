import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:home_widget/home_widget.dart';

void main() => runApp(MaterialApp(home: const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List result = List.filled(21, '', growable: false);

  bool isLoading = false;

  Future<List<String>> extractData() async {
    List<String> list = List.filled(21, '', growable: false);
    final response = await http.Client().get(Uri.parse(
        'https://www.changwon.ac.kr/dorm/na/ntt/selectNttList.do?mi=10079&bbsId=2918'));
    if (response.statusCode == 200) {
      var document = parser
          .parse(response.body)
          .getElementsByClassName('BD_table')[0]
          .children[0]
          .children[2];
      try {
        list[0] = document.children[2].children[2].text.trim();
        list[1] = document.children[4].children[2].text.trim();
        list[2] = document.children[7].children[2].text.trim();
        list[3] = document.children[2].children[3].text.trim();
        list[4] = document.children[4].children[3].text.trim();
        list[5] = document.children[7].children[3].text.trim();
        list[6] = document.children[2].children[4].text.trim();
        list[7] = document.children[4].children[4].text.trim();
        list[8] = document.children[7].children[4].text.trim();
        list[9] = document.children[2].children[5].text.trim();
        list[10] = document.children[4].children[5].text.trim();
        list[11] = document.children[7].children[5].text.trim();
        list[12] = document.children[2].children[6].text.trim();
        list[13] = document.children[4].children[6].text.trim();
        list[14] = document.children[7].children[6].text.trim();
        list[15] = document.children[2].children[7].text.trim();
        list[16] = document.children[4].children[7].text.trim();
        list[17] = document.children[7].children[7].text.trim();
        list[18] = document.children[2].children[8].text.trim();
        list[19] = document.children[4].children[8].text.trim();
        list[20] = document.children[7].children[8].text.trim();
        return list;
      } catch (e) {
        return ['ERROR!'];
      }
    } else {
      return ['ERROR: ${response.statusCode}.'];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });
      final response = await extractData();
      setState(() {
        result = response;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width * 0.7;
    double boxHeight = MediaQuery.of(context).size.height * 0.23;
    double fontSize = MediaQuery.of(context).size.height * 0.02;
    double titleFontSize = MediaQuery.of(context).size.height * 0.03;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff153c85),
            title: const Text('창대긱식'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final response = await extractData();
                  setState(() {
                    result = response;
                    isLoading = false;
                  });
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
                Tab(child: Text("토")),
                Tab(child: Text("일")),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TabBarView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
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
                                  Text("아침",
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
                                  Text("저녁",
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
                        )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
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
                                  Text("아침",
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
                                  Text("점심",
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
                                  Text(result[8],
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
                      ? const CircularProgressIndicator()
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
                                  Text("아침",
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
                                  Text("점심",
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
                                  Text("저녁",
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
                        )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
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
                                  Text("아침",
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
                                  Text("점심",
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
                                  Text("저녁",
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
                        )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
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
                                  Text("아침",
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
                                  Text("저녁",
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
                          ],
                        )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
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
                                  Text("아침",
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
                                  Text("점심",
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
                                  Text(result[20],
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
