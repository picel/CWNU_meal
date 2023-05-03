import 'package:cwnumeal/base/model/default_submodel.dart';

class DefaultModel {
  final List<DefaultSubModel> monday;
  final List<DefaultSubModel> tuesday;
  final List<DefaultSubModel> wednesday;
  final List<DefaultSubModel> thursday;
  final List<DefaultSubModel> friday;
  final String lastUpdate;

  DefaultModel({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.lastUpdate,
  });

  factory DefaultModel.fromJson(Map<String, dynamic> json) {
    return DefaultModel(
      monday: List<DefaultSubModel>.from(
          json['monday'].map((x) => DefaultSubModel.fromJson(x))),
      tuesday: List<DefaultSubModel>.from(
          json['tuesday'].map((x) => DefaultSubModel.fromJson(x))),
      wednesday: List<DefaultSubModel>.from(
          json['wednesday'].map((x) => DefaultSubModel.fromJson(x))),
      thursday: List<DefaultSubModel>.from(
          json['thursday'].map((x) => DefaultSubModel.fromJson(x))),
      friday: List<DefaultSubModel>.from(
          json['friday'].map((x) => DefaultSubModel.fromJson(x))),
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
      'lastUpdate': lastUpdate,
    };
  }
}
