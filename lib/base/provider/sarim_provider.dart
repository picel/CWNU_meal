import 'package:cwnumeal/base/model/default_model.dart';
import 'package:cwnumeal/base/repository/cdn_getter.dart';
import 'package:flutter/foundation.dart';

class SarimProvider extends ChangeNotifier {
  SarimProvider() {
    _loadSarim();
  }

  List _sarim = [];
  String _date = '';

  List get sarim => _sarim;
  String get date => _date;

  void refresh() {
    _sarim = [];
    _loadSarim();

    notifyListeners();
  }

  _loadSarim() async {
    CdnGetter cdnGetter = CdnGetter();
    DefaultModel sarim = await cdnGetter.fetchSarim();

    // append sarim
    _sarim.add(sarim.monday);
    _sarim.add(sarim.tuesday);
    _sarim.add(sarim.wednesday);
    _sarim.add(sarim.thursday);
    _sarim.add(sarim.friday);

    for (int i = 0; i < _sarim.length; i++) {
      for (int j = 0; j < _sarim[i].length; j++) {
        if (_sarim[i][j].content == "") {
          _sarim[i][j].content = "운영 중지";
        }
      }
    }

    _date = sarim.lastUpdate;

    notifyListeners();
  }
}
