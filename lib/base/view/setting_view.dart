import 'package:cwnumeal/base/provider/favorite_provider.dart';
import 'package:cwnumeal/base/provider/theme_provider.dart';
import 'package:cwnumeal/util/device_size.dart';
import 'package:cwnumeal/widget/neu_checkbox.dart';
import 'package:cwnumeal/widget/circle_positive_box.dart';
import 'package:cwnumeal/widget/jua_text.dart';
import 'package:cwnumeal/widget/negative_box.dart';
import 'package:cwnumeal/widget/neu_display_mode_switch.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();

  static const routeName = '/settings';
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: CirclePositiveBox(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: NeumorphicTheme.accentColor(context),
          ),
        ),
        title: JuaText(
          text: "추가 메뉴",
          fontSize: 30,
          bold: true,
          color: NeumorphicTheme.accentColor(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                JuaText(
                  text: "앱 설정",
                  fontSize: DeviceSize.height * 0.04,
                  bold: true,
                  color: NeumorphicTheme.accentColor(context),
                ),
                NegativeBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          JuaText(
                            text: "앱 테마 설정",
                            fontSize: DeviceSize.height * 0.03,
                            bold: false,
                            color: NeumorphicTheme.accentColor(context),
                          ),
                          NeuDisplaySwitch(
                            value: Provider.of<ThemeProvider>(context).darkMode,
                            onChanged: (value) {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .setDarkMode(value);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: DeviceSize.height * 0.01,
                      ),
                      Divider(
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      SizedBox(
                        height: DeviceSize.height * 0.01,
                      ),
                      JuaText(
                        text: "홈 화면에 표시할 식당",
                        fontSize: DeviceSize.height * 0.03,
                        bold: false,
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      NeuCheckBox(
                        value: Provider.of<FavoriteProvider>(context).dorm,
                        onChanged: (value) {
                          Provider.of<FavoriteProvider>(context, listen: false)
                              .setDorm((value == 1 ? true : false));
                        },
                        title: "기숙사",
                      ),
                      NeuCheckBox(
                        value: Provider.of<FavoriteProvider>(context).sarim,
                        onChanged: (value) {
                          Provider.of<FavoriteProvider>(context, listen: false)
                              .setSarim((value == 1 ? true : false));
                        },
                        title: "사림관",
                      ),
                      NeuCheckBox(
                        value: Provider.of<FavoriteProvider>(context).bonglim,
                        onChanged: (value) {
                          Provider.of<FavoriteProvider>(context, listen: false)
                              .setBonglim((value == 1 ? true : false));
                        },
                        title: "봉림관",
                      ),
                      JuaText(
                        text: "선택하신 식당이 앱 메인 화면에 표시됩니다.",
                        fontSize: DeviceSize.height * 0.02,
                        bold: false,
                        color: NeumorphicTheme.accentColor(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: DeviceSize.height * 0.05),
                JuaText(
                  text: "자주 묻는 질문",
                  fontSize: DeviceSize.height * 0.04,
                  bold: true,
                  color: NeumorphicTheme.accentColor(context),
                ),
                NegativeBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JuaText(
                        text: "Q. 식단 정보는 언제 업데이트 되나요?",
                        fontSize: DeviceSize.height * 0.027,
                        bold: false,
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      JuaText(
                        text:
                            "A. 매주 월요일 오전 0시, 3시, 7시, 10시, 12시에 학교 홈페이지에서 식단 정보를 가져옵니다.",
                        fontSize: DeviceSize.height * 0.02,
                        bold: false,
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      Divider(
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      JuaText(
                        text: "Q. 정보가 업데이트되지 않았어요!",
                        fontSize: DeviceSize.height * 0.027,
                        bold: false,
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      JuaText(
                        text: "A. 학교 홈페이지에서 식단 정보가 업데이트 되지 않았을 수 있습니다.",
                        fontSize: DeviceSize.height * 0.02,
                        bold: false,
                        color: NeumorphicTheme.accentColor(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: DeviceSize.height * 0.05),
                JuaText(
                  text: "앱 정보",
                  fontSize: DeviceSize.height * 0.04,
                  bold: true,
                  color: NeumorphicTheme.accentColor(context),
                ),
                NegativeBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: JuaText(
                          text: "앱 버전",
                          fontSize: DeviceSize.height * 0.027,
                          bold: false,
                          color: NeumorphicTheme.accentColor(context),
                        ),
                        subtitle: JuaText(
                          text: "3.1.0",
                          fontSize: DeviceSize.height * 0.02,
                          bold: false,
                          color: NeumorphicTheme.accentColor(context),
                        ),
                      ),
                      Divider(
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      ListTile(
                        title: JuaText(
                          text: "지원 메일",
                          fontSize: DeviceSize.height * 0.027,
                          bold: false,
                          color: NeumorphicTheme.accentColor(context),
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: "picel@ivis.dev",
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: JuaText(
                                  text: "이메일 주소가 복사되었습니다.",
                                  fontSize: DeviceSize.height * 0.02,
                                  bold: false,
                                  color: NeumorphicTheme.baseColor(context),
                                ),
                              ),
                            );
                          },
                          child: JuaText(
                            text: "picel@ivis.dev",
                            fontSize: DeviceSize.height * 0.02,
                            bold: false,
                            color: NeumorphicTheme.accentColor(context),
                          ),
                        ),
                      ),
                      Divider(
                        color: NeumorphicTheme.accentColor(context),
                      ),
                      ListTile(
                        subtitle: JuaText(
                          text:
                              "IVIS Lab\nDept. of Information & Communication Engineering, Changwon National University",
                          fontSize: DeviceSize.height * 0.015,
                          bold: false,
                          color: NeumorphicTheme.accentColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: DeviceSize.height * 0.05),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
