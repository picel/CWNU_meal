import 'package:carousel_slider/carousel_slider.dart';
import 'package:cwnumeal/base/provider/favorite_provider.dart';
import 'package:cwnumeal/base/provider/now_provider.dart';
import 'package:cwnumeal/util/device_size.dart';
import 'package:cwnumeal/util/text_height_expect.dart';
import 'package:cwnumeal/widget/circle_positive_box.dart';
import 'package:cwnumeal/widget/ibm_text.dart';
import 'package:cwnumeal/widget/jua_text.dart';
import 'package:cwnumeal/widget/square_positive_box.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        centerTitle: true,
        leading: CirclePositiveBox(
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
          child: Icon(
            Icons.settings,
            color: NeumorphicTheme.accentColor(context),
          ),
        ),
        actions: [
          CirclePositiveBox(
            onPressed: () {
              Provider.of<NowProvider>(context, listen: false).refresh();
            },
            child: Icon(
              Icons.refresh_rounded,
              color: NeumorphicTheme.accentColor(context),
            ),
          ),
        ],
        title: JuaText(
          text: "창대학식",
          fontSize: 30,
          bold: true,
          color: NeumorphicTheme.accentColor(context),
        ),
      ),
      body: Provider.of<FavoriteProvider>(context).isFavoriteEmpty
          ? Center(
              child: JuaText(
                text: "좌측 상단의 설정 메뉴에서\n식당을 추가해주세요!",
                fontSize: 20,
                bold: true,
                color: NeumorphicTheme.accentColor(context),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: DeviceSize.height * 0.01,
                      ),
                      for (var i = 0;
                          i <
                              Provider.of<FavoriteProvider>(context)
                                  .favoriteList
                                  .length;
                          i++)
                        Column(
                          children: [
                            JuaText(
                              text: Provider.of<FavoriteProvider>(context)
                                  .favoriteList[i]['kor']!,
                              fontSize: DeviceSize.height * 0.035,
                              bold: true,
                              color: NeumorphicTheme.accentColor(context),
                            ),
                            SizedBox(
                              height: DeviceSize.height * 0.02,
                            ),
                            SizedBox(
                              width: DeviceSize.width,
                              child: Provider.of<NowProvider>(context)
                                          .now[Provider.of<FavoriteProvider>(
                                                  context,
                                                  listen: false)
                                              .favoriteList[i]['eng']!]!
                                          .length ==
                                      0
                                  ? Center(
                                      child: SpinKitSquareCircle(
                                      color:
                                          NeumorphicTheme.accentColor(context),
                                      size: 30.0,
                                    ))
                                  : CarouselSlider(
                                      options: CarouselOptions(
                                        viewportFraction: 0.75,
                                        height: TextHeightExpect().textHeight(
                                          Provider.of<NowProvider>(context).now[
                                              Provider.of<FavoriteProvider>(
                                                      context,
                                                      listen: false)
                                                  .favoriteList[i]['eng']!]!,
                                          DeviceSize.height * 0.025,
                                          true,
                                        ),
                                        enableInfiniteScroll: true,
                                        initialPage: 0,
                                        clipBehavior: Clip.none,
                                      ),
                                      items: [
                                        for (var j = 0;
                                            j <
                                                Provider.of<NowProvider>(
                                                        context)
                                                    .now[Provider.of<
                                                                FavoriteProvider>(
                                                            context,
                                                            listen: false)
                                                        .favoriteList[i]['eng']!]!
                                                    .length;
                                            j++)
                                          SquarePositiveBox(
                                            width: DeviceSize.width * 0.6,
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  '/${Provider.of<FavoriteProvider>(context, listen: false).favoriteList[i]['eng']!}');
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IBMText(
                                                      text: Provider.of<
                                                                  NowProvider>(
                                                              context)
                                                          .now[Provider.of<
                                                                          FavoriteProvider>(
                                                                      context,
                                                                      listen: false)
                                                                  .favoriteList[
                                                              i]['eng']!][j]
                                                          .title,
                                                      fontSize:
                                                          DeviceSize.height *
                                                              0.025,
                                                      bold: true,
                                                      color: NeumorphicTheme
                                                          .accentColor(context),
                                                    ),
                                                    (Provider.of<FavoriteProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .favoriteList[
                                                                i]['eng']! ==
                                                            "dorm")
                                                        ? IBMText(
                                                            text:
                                                                " ${Provider.of<NowProvider>(context).now[Provider.of<FavoriteProvider>(context, listen: false).favoriteList[i]['eng']!][j].option}",
                                                            fontSize: DeviceSize
                                                                    .height *
                                                                0.025,
                                                            bold: true,
                                                            color: NeumorphicTheme
                                                                .accentColor(
                                                                    context),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      DeviceSize.height * 0.01,
                                                ),
                                                IBMText(
                                                  text:
                                                      "${Provider.of<NowProvider>(context).now[Provider.of<FavoriteProvider>(context, listen: false).favoriteList[i]['eng']!][j].content}",
                                                  fontSize:
                                                      DeviceSize.height * 0.02,
                                                  bold: true,
                                                  color: NeumorphicTheme
                                                      .accentColor(context),
                                                ),
                                              ],
                                            ),
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
                  ),
                ),
              ],
            ),
    );
  }
}
