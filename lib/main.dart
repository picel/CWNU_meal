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
    final response = await http.Client().get(Uri.parse('https://www.changwon.ac.kr/dorm/na/ntt/selectNttInfo.do?nttSn=1240653&mi=10079&editYn=N&listCo=15&hasManageBbsAuth=false&dietAuth=N'));
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
        result[0] = response[0];
        result[1] = response[1];
        result[2] = response[2];
        result[3] = response[3];
        result[4] = response[4];
        result[5] = response[5];
        result[6] = response[6];
        result[7] = response[7];
        result[8] = response[8];
        result[9] = response[9];
        result[10] = response[10];
        result[11] = response[11];
        result[12] = response[12];
        result[13] = response[13];
        result[14] = response[14];
        result[15] = response[15];
        result[16] = response[16];
        result[17] = response[17];
        result[18] = response[18];
        result[19] = response[19];
        result[20] = response[20];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    result[0] = response[0];
                    result[1] = response[1];
                    result[2] = response[2];
                    result[3] = response[3];
                    result[4] = response[4];
                    result[5] = response[5];
                    result[6] = response[6];
                    result[7] = response[7];
                    result[8] = response[8];
                    result[9] = response[9];
                    result[10] = response[10];
                    result[11] = response[11];
                    result[12] = response[12];
                    result[13] = response[13];
                    result[14] = response[14];
                    result[15] = response[15];
                    result[16] = response[16];
                    result[17] = response[17];
                    result[18] = response[18];
                    result[19] = response[19];
                    result[20] = response[20];
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
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Container(
                            height: 140,
                            width: 250,
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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

