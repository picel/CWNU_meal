import 'package:cwnumeal/sarim.dart';
import 'package:flutter/material.dart';

import 'bonglim.dart';
import 'main.dart';

class navDrawer extends StatelessWidget {
  const navDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/banner.png"),
                    fit: BoxFit.cover)
                  ), child: null,
              ),
              ListTile(
                title: const Text('기숙사'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context, PageRouteBuilder(pageBuilder: (_, __, ___) => MyApp()));
                }
              ),
              ListTile(
                title: const Text('봉림관'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context, PageRouteBuilder(pageBuilder: (_, __, ___) => Bonglim()));
                },
              ),
              ListTile(
                title: const Text('사림관'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context, PageRouteBuilder(pageBuilder: (_, __, ___) => Sarim()));
                },
              )
            ]
        )
    );
  }
}
