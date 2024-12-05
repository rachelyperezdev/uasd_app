// Petición del Cambio de Contraseña
class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmPassword});

  // Adapter de json a modelo
  Map<String, dynamic> toJson() {
    return {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
  }
}

// Respuesta del Cambio de Contraseña
class ChangePasswordResponse {
  final bool success;
  final String message;
  final String? error;

  ChangePasswordResponse({
    required this.success,
    required this.message,
    this.error,
  });

  // Adapter de json a modelo
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      success: json['success'],
      message: json['message'] ?? '',
      error: json['error'] ?? '',
    );
  }
}
