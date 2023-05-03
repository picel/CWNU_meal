import 'package:cwnumeal/base/provider/bonglim_provider.dart';
import 'package:cwnumeal/base/provider/dorm_provider.dart';
import 'package:cwnumeal/base/provider/favorite_provider.dart';
import 'package:cwnumeal/base/provider/now_provider.dart';
import 'package:cwnumeal/base/provider/sarim_provider.dart';
import 'package:cwnumeal/base/provider/theme_provider.dart';
import 'package:cwnumeal/base/view/bonglim_view.dart';
import 'package:cwnumeal/base/view/dorm_view.dart';
import 'package:cwnumeal/base/view/home_view.dart';
import 'package:cwnumeal/base/view/sarim_view.dart';
import 'package:cwnumeal/base/view/setting_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => NowProvider()),
        ChangeNotifierProvider(create: (_) => DormProvider()),
        ChangeNotifierProvider(create: (_) => SarimProvider()),
        ChangeNotifierProvider(create: (_) => BonglimProvider()),
      ],
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'neumorphic test',
      themeMode: themeProvider.darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffe5edf6),
        accentColor: const Color(0xff455a64),
        lightSource: LightSource.topLeft,
        defaultTextColor: const Color(0xff455a64),
        variantColor: const Color(0xff455a64),
        disabledColor: Colors.blueGrey,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: const Color(0xff455a64),
        accentColor: Color(0xffe5edf6),
        lightSource: LightSource.topLeft,
        defaultTextColor: const Color(0xffe5edf6),
        variantColor: const Color(0xffe5edf6),
        disabledColor: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/settings': (context) => const SettingsView(),
        '/dorm': (context) => const DormView(),
        '/sarim': (context) => const SarimView(),
        '/bonglim': (context) => const BonglimView(),
      },
    );
  }
}
