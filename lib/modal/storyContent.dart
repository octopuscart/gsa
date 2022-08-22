class StoryContent {
  final String? server_id;
  final String image_id;
  final String content;
  final String language_id;

  StoryContent({
    this.server_id,
    required this.image_id,
    required this.content,
    required this.language_id,
  });

  StoryContent.fromMap(Map<String, dynamic> res)
      : server_id = res["id"],
        image_id = res["image_id"],
        content = res["content"],
        language_id = res["language_id"];

  Map<String, Object?> toMap() {
    return {
      'server_id': server_id,
      'image_id': image_id,
      'content': content,
      'language_id': language_id,
    };
  }

  factory StoryContent.fromJson(Map<String, dynamic> json) {
    return StoryContent(
        server_id: json["id"],
        image_id: json["image_id"],
        language_id: json["language_id"],
        content: json["content"]);
  }
}
