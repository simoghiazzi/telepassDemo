class ReelModel {
  String id;
  String title;
  String imageUrl;
  bool highlighted;
  String? videoUrl; // Optional as not needed for the Demo

  ReelModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.highlighted,
    this.videoUrl,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) => ReelModel(
    id: json['id'],
    title: json['title'],
    imageUrl: json['image_url'],
    highlighted: json['highlighted'],
    videoUrl: json['video_url'],
  );
}
