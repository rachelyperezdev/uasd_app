import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/secure_storage/secure_storage_service.dart';
import 'package:uasd_app/core/services/location_service.dart';
import 'package:uasd_app/data/network/api_client.dart';

final getIt = GetIt.instance;

// http setup

void setup() async {
  getIt.registerSingleton<Dio>(Dio());

// Servicios
  getIt.registerSingleton<SecureStorageService>(SecureStorageService());

// API

  getIt.registerSingleton<ApiClient>(ApiClient(
      dio: getIt<Dio>(),
      secureStorageService: getIt<SecureStorageService>(),
      baseUrl: AppConstants.baseUrl));

  // Servicio
  getIt.registerLazySingleton<LocationService>(() => LocationService());
}
