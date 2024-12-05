// Modelo de Preselección
class PreselectionModel {
  final String course;
  final bool confirmed;
  final DateTime selectionDate;
  final String? courseCode;
  final String classroom;
  final String location;

  PreselectionModel(
      {required this.course,
      required this.confirmed,
      required this.selectionDate,
      this.courseCode,
      required this.classroom,
      required this.location});

  // Adapter de json a modelo
  factory PreselectionModel.fromJson(Map<String, dynamic> json) {
    return PreselectionModel(
      course: json['nombre'] as String? ?? '',
      confirmed: json['confirmada'] as bool? ?? false,
      selectionDate: json['fechaSeleccion'] != null
          ? DateTime.parse(json['fechaSeleccion'] as String)
          : DateTime.now(),
      courseCode: json['codigo'] as String?,
      classroom: json['aula'] as String? ?? '',
      location: json['ubicacion'] as String? ?? '',
    );
  }
}

// Modelo de Creación de Preselección
class CreatePreselectionModel {
  final String courseCode;

  CreatePreselectionModel({required this.courseCode});
}
