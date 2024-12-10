// Modelo de Asignatura
class CourseModel {
  final String code;
  final String name;
  final String schedule;
  final String classroom;
  final String location;

  CourseModel(
      {required this.code,
      required this.name,
      required this.schedule,
      required this.classroom,
      required this.location});

  // Adapter de json a modelo
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        code: json['codigo'],
        name: json['nombre'],
        schedule: json['horario'],
        classroom: json['aula'],
        location: json['ubicacion']);
  }
}
