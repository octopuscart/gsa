import 'curd.dart';

class StoryImages {
  final String? server_id;
  final String image;
  final String display_index;
  final String local_path;

  StoryImages({
    this.server_id,
    required this.image,
    required this.display_index,
    required this.local_path,
  });

  StoryImages.fromMap(Map<String, dynamic> res)
      : server_id = res["id"],
        image = res["image"],
        display_index = res["display_index"],
        local_path = res["local_path"];

  Map<String, Object?> toMap() {
    return {
      'server_id': server_id,
      'image': image,
      'display_index': display_index,
      'local_path': local_path
    };
  }

  factory StoryImages.fromJson(Map<String, dynamic> json) {
    return StoryImages(
        server_id: json["id"],
        image: json["image"],
        display_index: json["display_index"],
        local_path: "");
  }
}
