import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/auth/presentation/bloc/user/user_event.dart';
import 'package:uasd_app/features/auth/presentation/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<SetUser>((event, emit) {
      emit(UserState(user: event.user)); // establece el usuario
    });

    on<ClearUser>((event, emit) {
      emit(const UserState()); // remueve el usuario
    });
  }
}
