import 'package:cwnumeal/base/model/dorm_model.dart';
import 'package:cwnumeal/base/repository/cdn_getter.dart';
import 'package:flutter/foundation.dart';

class DormProvider extends ChangeNotifier {
  DormProvider() {
    _loadDorm();
  }

  List _dorm = [];
  String _date = '';
  List<List<String>> _titles = [];

  List get dorm => _dorm;
  String get date => _date;
  List<List<String>> get titles => _titles;

  void refresh() {
    _dorm = [];
    _loadDorm();

    notifyListeners();
  }

  _loadDorm() async {
    CdnGetter cdnGetter = CdnGetter();
    DormModel dorm = await cdnGetter.fetchDorm();

    // append dorm
    _dorm.add(dorm.monday);
    _dorm.add(dorm.tuesday);
    _dorm.add(dorm.wednesday);
    _dorm.add(dorm.thursday);
    _dorm.add(dorm.friday);
    _dorm.add(dorm.saturday);
    _dorm.add(dorm.sunday);

    for (int i = 0; i < _dorm.length; i++) {
      for (int j = 0; j < _dorm[i].length; j++) {
        if (_dorm[i][j].content == "") {
          _dorm[i][j].content = "운영 중지";
        }
      }
    }

    _date = dorm.lastUpdate;

    for (int i = 0; i < _dorm.length; i++) {
      List<String> temp = [];
      for (int j = 0; j < _dorm[i].length; j++) {
        temp.add(_dorm[i][j].title);
      }
      temp = temp.toSet().toList();
      _titles.add(temp);
    }

    notifyListeners();
  }
}
