import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider() {
    _loadFavorite();
  }

  bool _dorm = false;
  bool _sarim = false;
  bool _bonglim = false;

  bool get dorm => _dorm;
  bool get sarim => _sarim;
  bool get bonglim => _bonglim;

  bool get isFavoriteEmpty =>
      _dorm == false && _sarim == false && _bonglim == false;

  List<Map<String, String>> get favoriteList {
    List<Map<String, String>> list = [];
    if (_dorm) {
      list.add({'kor': '기숙사', 'eng': 'dorm'});
    }
    if (_sarim) {
      list.add({'kor': '사림관', 'eng': 'sarim'});
    }
    if (_bonglim) {
      list.add({'kor': '봉림관', 'eng': 'bonglim'});
    }
    return list;
  }

  void _loadFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _dorm = prefs.getBool('dorm') ?? false;
    _sarim = prefs.getBool('sarim') ?? false;
    _bonglim = prefs.getBool('bonglim') ?? false;
    notifyListeners();
  }

  void setDorm(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dorm', value);
    _dorm = value;
    notifyListeners();
  }

  void setSarim(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('sarim', value);
    _sarim = value;
    notifyListeners();
  }

  void setBonglim(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bonglim', value);
    _bonglim = value;
    notifyListeners();
  }
}
