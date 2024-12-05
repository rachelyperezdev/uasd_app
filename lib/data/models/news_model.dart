// Modelo de Noticias
class NewsModel {
  final String id;
  final String title;
  final String img;
  final String url;
  final String date;

  NewsModel(
      {required this.id,
      required this.title,
      required this.img,
      required this.url,
      required this.date});

  // Adapter de json a modelo
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        id: json["id"],
        title: json["title"],
        img: json["img"],
        url: json["url"],
        date: json["date"]);
  }
}