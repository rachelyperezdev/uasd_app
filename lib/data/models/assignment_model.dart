// Modelo de Tareas
class AssignmentModel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool completed;

  AssignmentModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.completed});

  // Adapter de json a modelo
  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
        id: json["id"],
        userId: json["usuarioId"],
        title: json["titulo"],
        description: json["descripcion"],
        dueDate: DateTime.parse(json["fechaVencimiento"] as String),
        completed: json["completada"]);
  }
}
