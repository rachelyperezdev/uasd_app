// Modelo de Video
class VideoModel {
  final int id;
  final String title;
  final String url;
  final String publicationDate;

  VideoModel(
      {required this.id,
      required this.title,
      required this.url,
      required this.publicationDate});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
        id: json['id'],
        title: json['titulo'],
        url: json['url'],
        publicationDate: json['fechaPublicacion']);
  }
}