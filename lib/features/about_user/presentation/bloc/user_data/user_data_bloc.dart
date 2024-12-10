import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/about_user/domain/get_userData_usecase.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/user_data/user_data_event.dart';
import 'package:uasd_app/features/about_user/presentation/bloc/user_data/user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final GetUserdataUsecase userdataUsecase;

  UserDataBloc({required this.userdataUsecase}) : super(UserDataInitial()) {
    on<FetchUserData>(_onFetchUserData);
  }

  Future<void> _onFetchUserData(
      FetchUserData event, Emitter<UserDataState> emit) async {
    emit(UserDataLoading()); // cargando

    final result = await userdataUsecase.execute(); // ejecuta el caso de uso

    // emite el resultado
    result.fold(
        (failure) => emit(UserDataError(
            message: 'No se pudo obtener los datos del usuario.')), (userData) {
      return emit(UserDataLoaded(user: userData));
    });
  }
}