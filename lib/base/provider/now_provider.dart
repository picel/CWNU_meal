import 'package:cwnumeal/base/model/dorm_model.dart';
import 'package:cwnumeal/base/repository/cdn_getter.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NowProvider extends ChangeNotifier {
  NowProvider() {
    _loadDorm();
    _loadSarim();
    _loadBonglim();
  }

  Map<String, dynamic> _now = {
    'dorm': [],
    'sarim': [],
    'bonglim': [],
  };

  Map<String, dynamic> get now => _now;

  void refresh() {
    _now = {
      'dorm': [],
      'sarim': [],
      'bonglim': [],
    };
    _loadDorm();
    _loadSarim();
    _loadBonglim();

    notifyListeners();
  }

  _loadDorm() async {
    CdnGetter cdnGetter = CdnGetter();
    DormModel dorm = await cdnGetter.fetchDorm();

    DateTime date = DateTime.now();
    String today = DateFormat('E').format(date);

    switch (today) {
      case 'Mon':
        _now['dorm'] = dorm.monday;
        break;
      case 'Tue':
        _now['dorm'] = dorm.tuesday;
        break;
      case 'Wed':
        _now['dorm'] = dorm.wednesday;
        break;
      case 'Thu':
        _now['dorm'] = dorm.thursday;
        break;
      case 'Fri':
        _now['dorm'] = dorm.friday;
        break;
      case 'Sat':
        _now['dorm'] = dorm.saturday;
        break;
      case 'Sun':
        _now['dorm'] = dorm.sunday;
        break;
    }

    for (int i = 0; i < _now['dorm'].length; i++) {
      if (_now['dorm'][i].content == "") {
        _now['dorm'].removeAt(i);
      }
    }

    notifyListeners();
  }

  _loadSarim() async {
    CdnGetter cdnGetter = CdnGetter();
    _now['sarim'] = await cdnGetter.fetchSarim();

    DateTime date = DateTime.now();
    String today = DateFormat('E').format(date);

    switch (today) {
      case 'Mon':
        _now['sarim'] = _now['sarim'].monday;
        break;
      case 'Tue':
        _now['sarim'] = _now['sarim'].tuesday;
        break;
      case 'Wed':
        _now['sarim'] = _now['sarim'].wednesday;
        break;
      case 'Thu':
        _now['sarim'] = _now['sarim'].thursday;
        break;
      case 'Fri':
        _now['sarim'] = _now['sarim'].friday;
        break;
    }

    notifyListeners();
  }

  _loadBonglim() async {
    CdnGetter cdnGetter = CdnGetter();
    _now['bonglim'] = await cdnGetter.fetchBonglim();

    DateTime date = DateTime.now();
    String today = DateFormat('E').format(date);

    switch (today) {
      case 'Mon':
        _now['bonglim'] = _now['bonglim'].monday;
        break;
      case 'Tue':
        _now['bonglim'] = _now['bonglim'].tuesday;
        break;
      case 'Wed':
        _now['bonglim'] = _now['bonglim'].wednesday;
        break;
      case 'Thu':
        _now['bonglim'] = _now['bonglim'].thursday;
        break;
      case 'Fri':
        _now['bonglim'] = _now['bonglim'].friday;
        break;
    }

    notifyListeners();
  }
}
