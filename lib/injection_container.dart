import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/secure_storage/secure_storage_service.dart';
import 'package:uasd_app/core/services/location_service.dart';
import 'package:uasd_app/data/network/api_client.dart';
import 'package:uasd_app/features/about_user/data/user_repository_impl.dart';
import 'package:uasd_app/features/about_user/domain/get_userData_usecase.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/user_data/user_data_bloc.dart';
import 'package:uasd_app/features/applications/data/application_repository.dart';
import 'package:uasd_app/features/applications/domain/application_usecase.dart';
import 'package:uasd_app/features/applications/presentation/bloc/add_application/add_application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/application_types/application_types_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/delete_application/delete_application_bloc.dart';
import 'package:uasd_app/features/assignments/data/assignments_repository_impl.dart';
import 'package:uasd_app/features/assignments/domain/get_assignments_usecase.dart';
import 'package:uasd_app/features/assignments/presentation/bloc/assignments_bloc.dart';
import 'package:uasd_app/features/auth/data/auth_repository_impl.dart';
import 'package:uasd_app/features/auth/domain/login_usecase.dart';
import 'package:uasd_app/features/auth/domain/logout_usecase.dart';
import 'package:uasd_app/features/auth/domain/reset_password_usecase.dart';
import 'package:uasd_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:uasd_app/features/debt/data/debt_repository_impl.dart';
import 'package:uasd_app/features/debt/domain/get_debts_usecase.dart';
import 'package:uasd_app/features/debt/presentation/bloc/debts_bloc.dart';
import 'package:uasd_app/features/events/data/events_repository_impl.dart';
import 'package:uasd_app/features/events/domain/get_events_usecase.dart';
import 'package:uasd_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:uasd_app/features/news/data/news_repository_impl.dart';
import 'package:uasd_app/features/news/domain/get_news_usecase.dart';
import 'package:uasd_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:uasd_app/features/preselection/data/courses_repository_impl.dart';
import 'package:uasd_app/features/preselection/data/preselection_repository_impl.dart';
import 'package:uasd_app/features/preselection/domain/get_courses_usecase.dart';
import 'package:uasd_app/features/preselection/domain/get_preselections_usecase.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/courses/courses_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/add_preselection/add_preselection_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/delete_preselection/delete_preselection_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/get_preselection/preselection_bloc.dart';
import 'package:uasd_app/features/schedule/data/schedule_repository_impl.dart';
import 'package:uasd_app/features/schedule/domain/get_schedule_usecase.dart';
import 'package:uasd_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:uasd_app/features/videos/data/videos_repository_impl.dart';
import 'package:uasd_app/features/videos/domain/get_videos_usecase.dart';
import 'package:uasd_app/features/videos/presentation/bloc/video_bloc.dart';

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

  /// USECASES
// Autenticación

  getIt.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl(
      apiClient: getIt<ApiClient>(),
      secureStorageService: getIt<SecureStorageService>()));

  getIt.registerSingleton<LoginUsecase>(
      LoginUsecase(authRepository: getIt<AuthRepositoryImpl>()));

  getIt.registerSingleton<ResetPasswordUsecase>(
      ResetPasswordUsecase(getIt<AuthRepositoryImpl>()));

  getIt.registerSingleton<LogoutUsecase>(
      LogoutUsecase(authRepository: getIt<AuthRepositoryImpl>()));

// Noticias

  getIt.registerSingleton<NewsRepositoryImpl>(
      NewsRepositoryImpl(apiClient: getIt<ApiClient>()));

  getIt.registerSingleton<GetNewsUsecase>(
      GetNewsUsecase(newsRepository: getIt<NewsRepositoryImpl>()));

// Videos

  getIt.registerSingleton<VideosRepositoryImpl>(
      VideosRepositoryImpl(apiClient: getIt<ApiClient>()));

  getIt.registerSingleton<GetVideosUsecase>(
      GetVideosUsecase(videosRepository: getIt<VideosRepositoryImpl>()));

// Eventos

  getIt.registerSingleton<EventsRepositoryImpl>(
      EventsRepositoryImpl(apiClient: getIt<ApiClient>()));

  getIt.registerSingleton<GetEventsUsecase>(
      GetEventsUsecase(eventsRepository: getIt<EventsRepositoryImpl>()));

// Id del usuario

  final userId = await getIt<SecureStorageService>().getUserId();

// Deudas

  getIt.registerSingleton<DebtRepositoryImpl>(DebtRepositoryImpl(
      apiClient: getIt<ApiClient>(), registeredUserId: userId ?? 0));

  getIt.registerSingleton<GetDebtsUsecase>(
      GetDebtsUsecase(debtRepository: getIt<DebtRepositoryImpl>()));

// Tareas

  getIt.registerSingleton<AssignmentsRepositoryImpl>(AssignmentsRepositoryImpl(
      apiClient: getIt<ApiClient>(), registeredUserId: userId ?? 0));

  getIt.registerSingleton<GetAssignmentsUsecase>(GetAssignmentsUsecase(
      assignmentsRepository: getIt<AssignmentsRepositoryImpl>()));

// Solicitudes

  getIt.registerSingleton<ApplicationRepositoryImpl>(
      ApplicationRepositoryImpl(apiClient: getIt<ApiClient>()));

  getIt.registerSingleton<ApplicationUsecase>(ApplicationUsecase(
      applicationRepository: getIt<ApplicationRepositoryImpl>()));

// Materias

  getIt.registerSingleton<CoursesRepositoryImpl>(
      CoursesRepositoryImpl(apiClient: getIt<ApiClient>()));

  getIt.registerSingleton<GetCoursesUsecase>(
      GetCoursesUsecase(coursesRepository: getIt<CoursesRepositoryImpl>()));

// Preselección

  getIt.registerSingleton<PreselectionRepositoryImpl>(
      PreselectionRepositoryImpl(apiClient: getIt<ApiClient>()));

  getIt.registerSingleton<GetPreselectionsUsecase>(GetPreselectionsUsecase(
      preselectionRepository: getIt<PreselectionRepositoryImpl>()));

// Horarios

  getIt.registerSingleton<ScheduleRepositoryImpl>(ScheduleRepositoryImpl(
      apiClient: getIt<ApiClient>(), registeredUserId: userId ?? 0));

  getIt.registerSingleton<GetScheduleUsecase>(
      GetScheduleUsecase(scheduleRepository: getIt<ScheduleRepositoryImpl>()));

// Sobre el Usuario
  getIt.registerSingleton<UserRepositoryImpl>(
      UserRepositoryImpl(apiClient: getIt<ApiClient>()));

  getIt.registerSingleton<GetUserdataUsecase>(
      GetUserdataUsecase(userRepository: getIt<UserRepositoryImpl>()));

  /// BLOCs
  // Autenticación
  getIt.registerFactory<LoginBloc>(() => LoginBloc(
      loginUsecase: getIt<LoginUsecase>(), apiClient: getIt<ApiClient>()));
  getIt.registerFactory<ResetPasswordBloc>(() =>
      ResetPasswordBloc(resetPasswordUsecase: getIt<ResetPasswordUsecase>()));
  getIt.registerSingleton<UserBloc>(UserBloc());
  getIt.registerFactory<LogoutBloc>(
      () => LogoutBloc(logoutUsecase: getIt<LogoutUsecase>()));

  // Noticias
  getIt.registerFactory<NewsBloc>(
      () => NewsBloc(getNewsUsecase: getIt<GetNewsUsecase>()));

  // Videos
  getIt.registerFactory<VideoBloc>(
      () => VideoBloc(videosUsecase: getIt<GetVideosUsecase>()));

  // Eventos
  getIt.registerFactory<EventsBloc>(
      () => EventsBloc(eventsUsecase: getIt<GetEventsUsecase>()));

  // Deudas
  getIt.registerFactory<DebtsBloc>(
      () => DebtsBloc(getDebtsUsecase: getIt<GetDebtsUsecase>()));

  // Tareas
  getIt.registerFactory<AssignmentsBloc>(() =>
      AssignmentsBloc(assignmentsUsecase: getIt<GetAssignmentsUsecase>()));

  // Solicitudes
  getIt.registerFactory<ApplicationBloc>(
      () => ApplicationBloc(applicationUsecase: getIt<ApplicationUsecase>()));
  getIt.registerFactory<ApplicationTypesBloc>(() =>
      ApplicationTypesBloc(applicationUsecase: getIt<ApplicationUsecase>()));
  getIt.registerFactory<AddApplicationBloc>(() =>
      AddApplicationBloc(applicationUsecase: getIt<ApplicationUsecase>()));
  getIt.registerFactory<DeleteApplicationBloc>(() =>
      DeleteApplicationBloc(applicationUsecase: getIt<ApplicationUsecase>()));

  // Materias
  getIt.registerFactory<CoursesBloc>(
      () => CoursesBloc(coursesUsecase: getIt<GetCoursesUsecase>()));

  // Preselección
  getIt.registerFactory<PreselectionBloc>(() =>
      PreselectionBloc(preselectionsUsecase: getIt<GetPreselectionsUsecase>()));
  getIt.registerFactory<DeletePreselectionBloc>(() => DeletePreselectionBloc(
      preselectionUsecase: getIt<GetPreselectionsUsecase>()));
  getIt.registerFactory<AddPreselectionBloc>(() => AddPreselectionBloc(
      preselectionUsecase: getIt<GetPreselectionsUsecase>()));

  // Horarios
  getIt.registerFactory<ScheduleBloc>(
      () => ScheduleBloc(scheduleUsecase: getIt<GetScheduleUsecase>()));

  // Sobre el Usuario
  getIt.registerFactory<UserDataBloc>(
      () => UserDataBloc(userdataUsecase: getIt<GetUserdataUsecase>()));

  getIt.registerFactory<ChangePasswordBloc>(
      () => ChangePasswordBloc(userdataUsecase: getIt<GetUserdataUsecase>()));

  // Servicio
  getIt.registerLazySingleton<LocationService>(() => LocationService());
}
