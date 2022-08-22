import 'curd.dart';

class StoryLanguage {
  final String? server_id;
  final String title;
  final String display_index;
  final String is_default;
  final String is_active;

  StoryLanguage({
    this.server_id,
    required this.title,
    required this.display_index,
    required this.is_default,
    required this.is_active,
  });

  StoryLanguage.fromMap(Map<String, dynamic> res)
      : server_id = res["id"],
        title = res["title"],
        display_index = res["display_index"],
        is_default = res["is_default"],
        is_active = res["is_active"];

  Map<String, Object?> toMap() {
    return {
      'server_id': server_id,
      'title': title,
      'display_index': display_index,
      'is_default': is_default,
      'is_active': is_active
    };
  }

  factory StoryLanguage.fromJson(Map<String, dynamic> json) {
    return StoryLanguage(
        server_id: json["id"],
        title: json["title"],
        display_index: json["display_index"],
        is_default: json["is_default"],
        is_active: json["is_active"]);
  }
}
