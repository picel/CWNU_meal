import 'package:cwnumeal/base/model/default_model.dart';
import 'package:cwnumeal/base/repository/cdn_getter.dart';
import 'package:flutter/foundation.dart';

class BonglimProvider extends ChangeNotifier {
  BonglimProvider() {
    _loadBonglim();
  }

  List _bonglim = [];
  String _date = '';
  List<List<String>> _titles = [];

  List get bonglim => _bonglim;
  String get date => _date;
  List<List<String>> get titles => _titles;

  void refresh() {
    _bonglim = [];
    _loadBonglim();

    notifyListeners();
  }

  _loadBonglim() async {
    CdnGetter cdnGetter = CdnGetter();
    DefaultModel Bonglim = await cdnGetter.fetchBonglim();

    // append Bonglim
    _bonglim.add(Bonglim.monday);
    _bonglim.add(Bonglim.tuesday);
    _bonglim.add(Bonglim.wednesday);
    _bonglim.add(Bonglim.thursday);
    _bonglim.add(Bonglim.friday);

    for (int i = 0; i < _bonglim.length; i++) {
      for (int j = 0; j < _bonglim[i].length; j++) {
        if (_bonglim[i][j].content == "") {
          _bonglim[i].removeAt(j);
        }
      }
    }

    _date = Bonglim.lastUpdate;

    for (int i = 0; i < _bonglim.length; i++) {
      List<String> temp = [];
      for (int j = 0; j < _bonglim[i].length; j++) {
        // add title's first three characters
        temp.add(_bonglim[i][j].title.substring(0, 3));
      }
      temp = temp.toSet().toList();
      _titles.add(temp);
    }

    notifyListeners();
  }
}
