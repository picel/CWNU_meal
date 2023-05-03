import 'package:cwnumeal/base/provider/bonglim_provider.dart';
import 'package:cwnumeal/util/device_size.dart';
import 'package:cwnumeal/util/get_dayOfWeek_int.dart';
import 'package:cwnumeal/widget/circle_positive_box.dart';
import 'package:cwnumeal/widget/ibm_text.dart';
import 'package:cwnumeal/widget/jua_text.dart';
import 'package:cwnumeal/widget/negative_box.dart';
import 'package:cwnumeal/widget/neu_switch.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class BonglimView extends StatefulWidget {
  const BonglimView({Key? key}) : super(key: key);

  @override
  State<BonglimView> createState() => _BonglimViewState();
}

class _BonglimViewState extends State<BonglimView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 5,
        initialIndex: DayOfWeekINT().weekdayToInt(true),
        child: Scaffold(
          appBar: NeumorphicAppBar(
            title: JuaText(
              text: "봉림관",
              fontSize: 30,
              bold: true,
              color: NeumorphicTheme.accentColor(context),
            ),
            leading: CirclePositiveBox(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: NeumorphicTheme.accentColor(context),
              ),
            ),
            actions: [
              CirclePositiveBox(
                onPressed: () {
                  Provider.of<BonglimProvider>(context, listen: false)
                      .refresh();
                },
                child: Icon(
                  Icons.refresh_rounded,
                  color: NeumorphicTheme.accentColor(context),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: TabBar(
              unselectedLabelColor: Colors.grey[400],
              indicatorColor: Colors.transparent,
              labelColor: NeumorphicTheme.accentColor(context),
              tabs: const [
                Tab(child: Text("월")),
                Tab(child: Text("화")),
                Tab(child: Text("수")),
                Tab(child: Text("목")),
                Tab(child: Text("금")),
              ],
            ),
          ),
          body: TabBarView(
            children: List<Widget>.generate(5, (int index) {
              return (Provider.of<BonglimProvider>(context).bonglim.length ==
                          0 ||
                      Provider.of<BonglimProvider>(context).titles.length == 0)
                  ? Center(
                      child: SpinKitSquareCircle(
                      color: NeumorphicTheme.accentColor(context),
                      size: 30.0,
                    ))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          NeuSwitch(
                            elements: Provider.of<BonglimProvider>(context)
                                .titles[index],
                            onChanged: (idx) {
                              setState(() {
                                _selectedIndex = idx;
                              });
                            },
                            selectedIndex: _selectedIndex,
                          ),
                          SizedBox(
                            height: DeviceSize.height * 0.02,
                          ),
                          Column(
                            children: List<Widget>.generate(
                                Provider.of<BonglimProvider>(context)
                                    .bonglim[index]
                                    .length, (int index2) {
                              return Column(
                                children: [
                                  Column(
                                    children: [
                                      NegativeBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IBMText(
                                              text:
                                                  "${Provider.of<BonglimProvider>(context).bonglim[index][index2].title}",
                                              fontSize:
                                                  DeviceSize.height * 0.025,
                                              bold: true,
                                              color:
                                                  NeumorphicTheme.accentColor(
                                                      context),
                                            ),
                                            SizedBox(
                                              height: DeviceSize.height * 0.01,
                                            ),
                                            IBMText(
                                              text:
                                                  Provider.of<BonglimProvider>(
                                                          context,
                                                          listen: false)
                                                      .bonglim[index][index2]
                                                      .content,
                                              fontSize:
                                                  DeviceSize.height * 0.02,
                                              bold: true,
                                              color:
                                                  NeumorphicTheme.accentColor(
                                                      context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: DeviceSize.height * 0.03,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
