import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Servicio destinado al manejo de data sensible
class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  // TOKEN

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }

  // USER ID
  Future<void> saveUserId(int userId) async {
    await _storage.write(key: 'user_id', value: userId.toString());
  }

  Future<int?> getUserId() async {
    final userId = await _storage.read(key: 'user_id');
    return userId != null ? int.parse(userId) : null;
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: 'user_id');
  }
}
