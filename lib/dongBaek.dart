import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'globals.dart' as globals;

void main() => runApp(
    const NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'neumorphic test',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffe5edf6),
        lightSource: LightSource.topLeft,
      ),
      home: DBaek(),
    )
);

class DBaek extends StatefulWidget {
  const DBaek({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<DBaek> with WidgetsBindingObserver {
  List result = List.filled(10, '', growable: false);
  bool isLoading = false;
  int dayOfWeek = globals.dayOfWeek;

  String lctime = "(11:30 ~ 14:00)";
  String dntime = "(17:00 ~ 18:00)";

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
      http.Response response = await http.get(Uri.parse('https://MiscellaneousFiles.b-cdn.net/bonglim.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var dataset = jsonDecode(jsonData);
      setState(() {
        int k = 0;
        for(int i = 0; i < 5; i++){
          for(int j = 0; j < 2; j++){
            result[k] = dataset[i.toString()][j];
            k++;
          }
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        for (int i = 0; i <= 9; i++) result[i] = '???????????? ??????';
        isLoading = false;
      });
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double titleFontSize = MediaQuery.of(context).size.height * 0.024;
    double fontSize = MediaQuery.of(context).size.height * 0.02;
    double boxWidth = MediaQuery.of(context).size.width * 0.6;
    double boxmargin = MediaQuery.of(context).size.height * 0.01;
    double boxpadding = MediaQuery.of(context).size.height * 0.022;
    Color mainColor = const Color(0xff455a64);
    if(dayOfWeek >= 5) dayOfWeek = 0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: dayOfWeek,
        length: 5,
        child: Scaffold(
            backgroundColor: NeumorphicTheme.baseColor(context),
            floatingActionButton: NeumorphicFloatingActionButton(
              mini: true,
              child: Icon(Icons.public,
                size: 30,
                color: mainColor,
              ),
              onPressed: _launchURL,
            ),
            appBar: NeumorphicAppBar(
              title: Text('?????????',
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
                  Navigator.pop(context);
                },
                style: const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 10,
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
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
            bottomNavigationBar: SafeArea(
              child: TabBar(
                unselectedLabelColor: Colors.grey[400],
                indicatorColor: Colors.transparent,
                labelColor: mainColor,
                tabs: const [
                  Tab(child: Text("???")),
                  Tab(child: Text("???")),
                  Tab(child: Text("???")),
                  Tab(child: Text("???")),
                  Tab(child: Text("???")),
                ],
              ),
            ),
            body: TabBarView(
                children: List<Widget>.generate(5, (idx) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLoading ? SpinKitSquareCircle(
                          color: mainColor,
                          size: 30.0,
                        ) : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Neumorphic(
                              padding: EdgeInsets.all(boxpadding),
                              margin: EdgeInsets.all(boxmargin),
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                                depth: -3,
                              ),
                              child: SizedBox(
                                  width: boxWidth,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("?????? $lctime",
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
                                      Text(result[idx * 2],
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
                            Neumorphic(
                              padding: EdgeInsets.all(boxpadding),
                              margin: EdgeInsets.all(boxmargin),
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                                depth: -3,
                              ),
                              child: SizedBox(
                                  width: boxWidth,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("?????? $dntime",
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
                                      Text(result[idx * 2 + 1],
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
                      ]
                  );
                })
            )
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