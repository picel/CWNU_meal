import 'dart:convert';

import 'package:cwnumeal/base/model/default_model.dart';
import 'package:cwnumeal/base/model/dorm_model.dart';
import 'package:http/http.dart' as http;

class CdnGetter {
  Future fetchDorm() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://cwnu-meal.b-cdn.net/dorm.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var dorm = jsonDecode(jsonData);

      return DormModel.fromJson(dorm);
    } catch (e) {
      print(e);
    }
  }

  Future<DefaultModel> fetchSarim() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://cwnu-meal.b-cdn.net/sarim.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var defaultModel = jsonDecode(jsonData);

      return DefaultModel.fromJson(defaultModel);
    } catch (e) {
      return DefaultModel.fromJson({
        'monday': [],
        'tuesday': [],
        'wednesday': [],
        'thursday': [],
        'friday': [],
        'date': '',
      });
    }
  }

  Future<DefaultModel> fetchBonglim() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://cwnu-meal.b-cdn.net/bonglim.json'));
      String jsonData = utf8.decode(response.bodyBytes);
      var defaultModel = jsonDecode(jsonData);

      return DefaultModel.fromJson(defaultModel);
    } catch (e) {
      return DefaultModel.fromJson({
        'monday': [],
        'tuesday': [],
        'wednesday': [],
        'thursday': [],
        'friday': [],
        'date': '',
      });
    }
  }
}
