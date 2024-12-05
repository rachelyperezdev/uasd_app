import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_card.dart';
import 'package:uasd_app/core/widgets/customized_dialogs.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/data/models/preselection_model.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/delete_preselection/delete_preselection_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/delete_preselection/delete_preselection_event.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/delete_preselection/delete_preselection_state.dart';

class ConfirmedPreselectionContainer extends StatefulWidget {
  final List<PreselectionModel> preselection;
  final Future<void> Function() refreshConfirmedPreselection;

  ConfirmedPreselectionContainer({
    super.key,
    required this.preselection,
    required this.refreshConfirmedPreselection,
  });

  @override
  ConfirmedPreselectionContainerState createState() =>
      ConfirmedPreselectionContainerState();
}

class ConfirmedPreselectionContainerState
    extends State<ConfirmedPreselectionContainer> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildConfirmedBlocListener();
  }

  // BLoC listener
  BlocListener<DeletePreselectionBloc, DeletePreselectionState>
      _buildConfirmedBlocListener() {
    return BlocListener<DeletePreselectionBloc, DeletePreselectionState>(
      listener: (context, state) {
        if (state is DeletePreselectionSuccess) {
          setState(() {
            widget.preselection.removeWhere(
                (preselection) => preselection.courseCode == state.courseCode);
          });
          widget.refreshConfirmedPreselection();
        }
      },
      child: BlocBuilder<DeletePreselectionBloc, DeletePreselectionState>(
        builder: (context, state) {
          if (state is DeletePreselectionLoading) {
            return Center(child: buildLoading());
          }
          if (state is DeletePreselectionError) {
            return Center(child: Text(state.message));
          }
          return buildConfirmedPreselectionList(
              preselection: widget.preselection
                  .where((preselection) => preselection.confirmed)
                  .toList());
        },
      ),
    );
  }

  // Listado de las preselecciones confirmadas
  Widget buildConfirmedPreselectionList(
      {required List<PreselectionModel> preselection}) {
    if (preselection.isEmpty) {
      return buildMessageContainer(message: 'No hay preselecciones');
    } else {
      return Column(
        children: preselection.map((preselection) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _buildPreselectionCard(context, preselection),
          );
        }).toList(),
      );
    }
  }

  // Listado de las preselecciones no confirmadas
  Widget _buildPreselectionCard(
      BuildContext context, PreselectionModel preselection) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: buildCardDecoration(Colors.teal),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildConfirmedPreselectionHeader(
                  context: context, preselection: preselection),
              SizedBox(height: 8),
              buildTag(message: preselection.courseCode!),
              SizedBox(height: 8),
              buildSubtitle(title: preselection.course, content: ''),
              SizedBox(height: 8),
              buildSubtitle(title: 'Aula: ', content: preselection.classroom),
            ],
          ),
        ),
      ),
    );
  }

  // Encabezado de las preselecciones confirmadas
  Widget _buildConfirmedPreselectionHeader(
      {required BuildContext context,
      required PreselectionModel preselection}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            preselection.course,
            style: const TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// para la actualización
class UnconfirmedPreselectionContainer extends StatefulWidget {
  final List<PreselectionModel> preselection;
  final Future<void> Function() refreshUnconfirmedPreselection;

  UnconfirmedPreselectionContainer({
    super.key,
    required this.preselection,
    required this.refreshUnconfirmedPreselection,
  });

  @override
  UnconfirmedPreselectionContainerState createState() =>
      UnconfirmedPreselectionContainerState();
}

class UnconfirmedPreselectionContainerState
    extends State<UnconfirmedPreselectionContainer> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUnconfirmedBlocListener();
  }

  BlocListener<DeletePreselectionBloc, DeletePreselectionState>
      _buildUnconfirmedBlocListener() {
    return BlocListener<DeletePreselectionBloc, DeletePreselectionState>(
      listener: (context, state) {
        if (state is DeletePreselectionSuccess) {
          setState(() {
            widget.preselection.removeWhere(
                (preselection) => preselection.courseCode == state.courseCode);
          });
          widget.refreshUnconfirmedPreselection();
        }
      },
      child: BlocBuilder<DeletePreselectionBloc, DeletePreselectionState>(
        builder: (context, state) {
          if (state is DeletePreselectionLoading) {
            return Center(child: buildLoading());
          }
          if (state is DeletePreselectionError) {
            return Center(child: Text(state.message));
          }
          return buildUnconfirmedPreselectionList(
              preselection: widget.preselection
                  .where((preselection) => !preselection.confirmed)
                  .toList());
        },
      ),
    );
  }

  Widget buildUnconfirmedPreselectionList(
      {required List<PreselectionModel> preselection}) {
    if (preselection.isEmpty) {
      return buildMessageContainer(message: 'No hay preselecciones');
    } else {
      return Column(
        children: preselection.map((preselection) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _buildPreselectionCard(context, preselection),
          );
        }).toList(),
      );
    }
  }

  Widget _buildPreselectionCard(
      BuildContext context, PreselectionModel preselection) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: buildCardDecoration(Colors.red.shade300),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildUnconfirmedPreselectionHeader(
                  context: context, preselection: preselection),
              SizedBox(height: 8),
              buildTag(message: preselection.courseCode!),
              SizedBox(height: 8),
              buildSubtitle(title: preselection.course, content: ''),
              SizedBox(height: 8),
              buildSubtitle(title: 'Aula: ', content: preselection.classroom),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnconfirmedPreselectionHeader(
      {required BuildContext context,
      required PreselectionModel preselection}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            preselection.course,
            style: const TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        if (!preselection.confirmed)
          Flexible(
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () => _showUnconfirmedPreselectionCancellationDialog(
                    context: context, preselection: preselection),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: AppConstants.primaryColor,
                ),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: AppConstants.tertiaryTxtColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showUnconfirmedPreselectionCancellationDialog(
      {required BuildContext context,
      required PreselectionModel preselection}) async {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CancellationDialog(
            onConfirm: () {
              BlocProvider.of<DeletePreselectionBloc>(context).add(
                  DeletePreselectionEvent(
                      courseCode: preselection.courseCode!));
            },
            title: 'Cancelar preselección',
            description:
                '¿Está seguro de que desea cancelar la preselección para "${preselection.course}"?',
            actionBtnTitle: 'Confirmar');
      },
    );
  }
}
