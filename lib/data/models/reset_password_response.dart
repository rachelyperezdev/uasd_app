// Modelo de Respuesta del Restablecimiento de Contraseña
class ResetPasswordResponseModel {
  final bool success;
  final String message;
  final String? error;

  ResetPasswordResponseModel({
    required this.success,
    required this.message,
    this.error,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      success: json['success'],
      message: json['message'],
      error: json['error'],
    );
  }
}
