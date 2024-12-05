// Modelo de Horario
class ScheduleModel {
  final int id;
  final int userId;
  final String course;
  final String classroom;
  final DateTime dateHour;
  final String location;

  ScheduleModel(
      {required this.id,
      required this.userId,
      required this.course,
      required this.classroom,
      required this.dateHour,
      required this.location});

  // Adapter de json a modelo
  factory ScheduleModel.toJson(Map<String, dynamic> json) {
    return ScheduleModel(
        id: json['id'],
        userId: json['usuarioId'],
        course: json['materia'],
        classroom: json['aula'],
        dateHour: DateTime.parse(json['fechaHora'] as String),
        location: json['ubicacion']);
  }
}
