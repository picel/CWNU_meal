import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

void main() => runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.green[100],
      primaryColor: Colors.green, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
    ),
    home: const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List result = List.filled(21, '', growable: false);

  bool isLoading = false;

  Future<List<String>> extractData() async {
    final response = await http.Client().get(Uri.parse('https://www.changwon.ac.kr/dorm/na/ntt/selectNttList.do?mi=10079&bbsId=2918'));
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        var monbf = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[2]
            .children[2];
        var monln = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[4]
            .children[2];
        var mondn = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[7]
            .children[2];
        var tuebf = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[2]
            .children[3];
        var tueln = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[4]
            .children[3];
        var tuedn = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[7]
            .children[3];
        var wedbf = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[2]
            .children[4];
        var wedln = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[4]
            .children[4];
        var weddn = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[7]
            .children[4];
        var thubf = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[2]
            .children[5];
        var thuln = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[4]
            .children[5];
        var thudn = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[7]
            .children[5];
        var fribf = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[2]
            .children[6];
        var friln = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[4]
            .children[6];
        var fridn = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[7]
            .children[6];
        var satbf = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[2]
            .children[7];
        var satln = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[4]
            .children[7];
        var satdn = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[7]
            .children[7];
        var sunbf = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[2]
            .children[8];
        var sunln = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[4]
            .children[8];
        var sundn = document
            .getElementsByClassName('BD_table')[0]
            .children[0]
            .children[2]
            .children[7]
            .children[8];
        return [monbf.text.trim(), monln.text.trim(), mondn.text.trim(), tuebf.text.trim(), tueln.text.trim(), tuedn.text.trim(), wedbf.text.trim(), wedln.text.trim(), weddn.text.trim(), thubf.text.trim(), thuln.text.trim(), thudn.text.trim(), fribf.text.trim(), friln.text.trim(), fridn.text.trim(), satbf.text.trim(), satln.text.trim(), satdn.text.trim(), sunbf.text.trim(), sunln.text.trim(), sundn.text.trim()];
      } catch (e) {
        return ['ERROR!'];
      }
    }
    else {
      return ['ERROR: ${response.statusCode}.'];
    }
  }


  @override
  void initState () {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });
      final response = await extractData();
      setState(() {
        for(int i = 0; i <= 20; i++){
          result[i] = response[i];
        }
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width * 0.7;
    double boxHeight = MediaQuery.of(context).size.height * 0.2;
    double fontSize = MediaQuery.of(context).size.height * 0.025;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
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
                    for(int i = 0; i <= 20; i++){
                      result[i] = response[i];
                    }
                    isLoading = false;
                  });
                },)
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
            child: TabBarView(
                children: [
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
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  offset: Offset(0, 1)
                                )
                              ]
                            ),
                            child: Text(result[0],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[1],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[2],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
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
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[3],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[4],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[5],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
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
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[6],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[7],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[8],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
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
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[9],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[10],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[11],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
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
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[12],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[13],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[14],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
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
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[15],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[16],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[17],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
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
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[18],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[19],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 1)
                                  )
                                ]
                            ),
                            child: Text(result[20],
                                style: TextStyle(
                                    fontSize: fontSize, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                    ],
                  ),
                ]
            ),
          ),

        ),
      ),
    );
  }
}

