import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/features/assignments/domain/get_assignments_usecase.dart';
import 'package:uasd_app/features/assignments/presentation/bloc/assignment_event.dart';
import 'package:uasd_app/features/assignments/presentation/bloc/assignment_state.dart';

class AssignmentsBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final GetAssignmentsUsecase assignmentsUsecase;

  AssignmentsBloc({required this.assignmentsUsecase})
      : super(AssignmentInitial()) {
    on<FetchAssignments>(_fetchAssignments);
    on<FetchCompletedAssignments>(_fetchCompletedAssignments);
    on<FetchPendingAssignments>(_fetchPendingAssignments);
  }

  Future<void> _fetchAssignments(
      FetchAssignments event, Emitter<AssignmentState> emit) async {
    emit(AssignmentLoading()); // cargando

    final response =
        await assignmentsUsecase.callAssignments(); // llama al caso de uso

    // emite
    response.fold(
        (failure) => emit(
            AssignmentsError(message: "No se pudieron cargar las tareas.")),
        (assignments) {
      if (assignments.isEmpty) {
        return emit(NoAssignments());
      } else {
        return emit(AssignmentsLoaded(assignments: assignments));
      }
    });
  }

  Future<void> _fetchCompletedAssignments(
      FetchCompletedAssignments event, Emitter<AssignmentState> emit) async {
    emit(AssignmentLoading());

    final response = await assignmentsUsecase.callCompletedAssignments();

    response.fold(
        (failure) => emit(CompletedAssignmentsError(
            message: "No se pudieron cargar las tareas completadas.")),
        (completedAssignments) => emit(CompletedAssignmentsLoaded(
            completedAssignments: completedAssignments)));
  }

  Future<void> _fetchPendingAssignments(
      FetchPendingAssignments event, Emitter<AssignmentState> emit) async {
    emit(AssignmentLoading());

    final response = await assignmentsUsecase.callPendingAssignments();

    response.fold(
        (failure) => emit(PendingAssignmentsError(
            message: "No se pudieron cargar las tareas pendientes.")),
        (pendingAssignments) => emit(
            PendingAssignmentsLoaded(pendingAssignments: pendingAssignments)));
  }
}