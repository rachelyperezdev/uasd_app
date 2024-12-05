// Modelo de Evento
class EventModel {
  final int id;
  final String title;
  final String description;
  final DateTime eventDate;
  final String location;
  final String coordinates;

  EventModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.eventDate,
      required this.location,
      required this.coordinates});

  // Adapter de json a modelo
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'],
        title: json['titulo'],
        description: json['descripcion'],
        eventDate: DateTime.parse(json['fechaEvento'] as String),
        location: json['lugar'],
        coordinates: json['coordenadas']);
  }
}