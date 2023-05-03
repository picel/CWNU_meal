class DefaultSubModel {
  String title;
  String content;

  DefaultSubModel({
    required this.title,
    required this.content,
  });

  factory DefaultSubModel.fromJson(Map<String, dynamic> json) {
    return DefaultSubModel(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
