class DormSubModel {
  String title;
  String option;
  String content;

  DormSubModel({
    required this.title,
    required this.option,
    required this.content,
  });

  factory DormSubModel.fromJson(Map<String, dynamic> json) {
    return DormSubModel(
      title: json['title'],
      option: json['option'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'option': option,
      'content': content,
    };
  }
}
