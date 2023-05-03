import 'package:cwnumeal/base/model/default_submodel.dart';
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
        _now['dorm'][i].content = "운영 중지";
      }
    }

    notifyListeners();
  }

  _loadSarim() async {
    CdnGetter cdnGetter = CdnGetter();
    var data = await cdnGetter.fetchSarim();

    DateTime date = DateTime.now();
    String today = DateFormat('E').format(date);

    switch (today) {
      case 'Mon':
        _now['sarim'] = data.monday;
        break;
      case 'Tue':
        _now['sarim'] = data.tuesday;
        break;
      case 'Wed':
        _now['sarim'] = data.wednesday;
        break;
      case 'Thu':
        _now['sarim'] = data.thursday;
        break;
      case 'Fri':
        _now['sarim'] = data.friday;
        break;
      default:
        _now['sarim'] = [
          DefaultSubModel(
            title: '운영 중지',
            content: '주말은 쉬어요!',
          ),
        ];
        break;
    }

    for (int i = 0; i < _now['sarim'].length; i++) {
      if (_now['sarim'][i].content == "") {
        _now['sarim'][i].content = "운영 중지";
      }
    }

    notifyListeners();
  }

  _loadBonglim() async {
    CdnGetter cdnGetter = CdnGetter();
    var data = await cdnGetter.fetchBonglim();

    DateTime date = DateTime.now();
    String today = DateFormat('E').format(date);

    switch (today) {
      case 'Mon':
        _now['bonglim'] = data.monday;
        break;
      case 'Tue':
        _now['bonglim'] = data.tuesday;
        break;
      case 'Wed':
        _now['bonglim'] = data.wednesday;
        break;
      case 'Thu':
        _now['bonglim'] = data.thursday;
        break;
      case 'Fri':
        _now['bonglim'] = data.friday;
        break;
      default:
        _now['bonglim'] = [
          DefaultSubModel(
            title: '운영 중지',
            content: '주말은 쉬어요!',
          ),
        ];
        break;
    }

    for (int i = 0; i < _now['bonglim'].length; i++) {
      if (_now['bonglim'][i].content == "") {
        _now['bonglim'][i].content = "운영 중지";
      }
    }

    notifyListeners();
  }
}
