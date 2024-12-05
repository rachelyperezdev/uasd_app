// Modelo de Solicitud
class ApplicationModel {
  final int id;
  final int userId;
  final String type;
  final String description;
  final String status;
  final DateTime applicationDate;
  final DateTime? responseDate;
  final String? response;

  ApplicationModel(
      {required this.id,
      required this.userId,
      required this.type,
      required this.description,
      required this.status,
      required this.applicationDate,
      this.responseDate,
      this.response});

  // Adapter del json al modelo
  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    String formatString(String input) {
      return input.replaceAll(RegExp(r'[^a-zA-Z]'), ' ');
    }

    return ApplicationModel(
      id: json["id"],
      userId: json["usuarioId"],
      type: formatString(json["tipo"]),
      description: formatString(json["descripcion"]),
      status: formatString(json["estado"]),
      applicationDate: DateTime.parse(json["fechaSolicitud"] as String),
      responseDate: json["fechaRespuesta"] != null
          ? DateTime.parse(json["fechaRespuesta"] as String)
          : null,
      response: json["respuesta"] as String?,
    );
  }
}

// Modelo de Creación de Solicitud
class CreateApplicationModel {
  final String type;
  final String description;

  CreateApplicationModel({required this.type, required this.description});

  Map<String, dynamic> toJson() {
    return {"tipo": type, "descripcion": description};
  }

  factory CreateApplicationModel.fromJson(Map<String, dynamic> json) {
    return CreateApplicationModel(
        type: json["tipo"], description: json["descripcion"]);
  }
}

// Modelo de Tipo de Solicitud
class ApplicationTypeModel {
  final String code;
  final String description;

  ApplicationTypeModel({required this.code, required this.description});

  // Adapter de json a modelo
  factory ApplicationTypeModel.fromJson(Map<String, dynamic> json) {
    return ApplicationTypeModel(
        code: json["codigo"], description: json["descripcion"]);
  }
}
