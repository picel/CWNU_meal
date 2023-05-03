import 'package:cwnumeal/base/model/dorm_submodel.dart';

class DormModel {
  final List<DormSubModel> monday;
  final List<DormSubModel> tuesday;
  final List<DormSubModel> wednesday;
  final List<DormSubModel> thursday;
  final List<DormSubModel> friday;
  final List<DormSubModel> saturday;
  final List<DormSubModel> sunday;
  final String lastUpdate;

  DormModel({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.lastUpdate,
  });

  factory DormModel.fromJson(Map<String, dynamic> json) {
    return DormModel(
      monday: List<DormSubModel>.from(
          json['monday'].map((x) => DormSubModel.fromJson(x))),
      tuesday: List<DormSubModel>.from(
          json['tuesday'].map((x) => DormSubModel.fromJson(x))),
      wednesday: List<DormSubModel>.from(
          json['wednesday'].map((x) => DormSubModel.fromJson(x))),
      thursday: List<DormSubModel>.from(
          json['thursday'].map((x) => DormSubModel.fromJson(x))),
      friday: List<DormSubModel>.from(
          json['friday'].map((x) => DormSubModel.fromJson(x))),
      saturday: List<DormSubModel>.from(
          json['saturday'].map((x) => DormSubModel.fromJson(x))),
      sunday: List<DormSubModel>.from(
          json['sunday'].map((x) => DormSubModel.fromJson(x))),
      lastUpdate: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
      'lastUpdate': lastUpdate,
    };
  }
}
