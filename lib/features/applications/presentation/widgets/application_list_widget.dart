import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_dialogs.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/data/models/application_model.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_state.dart';
import 'package:uasd_app/features/applications/presentation/bloc/delete_application/delete_application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/delete_application/delete_application_event.dart';
import 'package:uasd_app/features/applications/presentation/bloc/delete_application/delete_application_state.dart';

class ApplicationListWidget extends StatefulWidget {
  final List<ApplicationModel> applications;
  final Future<void> Function() refreshApplications;
  final Future<void> Function(ApplicationModel) onDelete;

  ApplicationListWidget({
    super.key,
    required this.applications,
    required this.refreshApplications,
    required this.onDelete,
  });

  @override
  ApplicationListWidgetState createState() => ApplicationListWidgetState();
}

class ApplicationListWidgetState extends State<ApplicationListWidget> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBlocListener(context: context);
  }

  BlocListener<DeleteApplicationBloc, DeleteApplicationState>
      _buildBlocListener({required BuildContext context}) {
    return BlocListener<DeleteApplicationBloc, DeleteApplicationState>(
      listener: (context, state) {
        if (state is DeleteApplicationSuccess) {
          setState(() {
            widget.applications.removeWhere((application) =>
                application.id == state.applicationId); // remueve la solicitud
          });
          widget.refreshApplications();
        }
      },
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          if (state is ApplicationLoading) {
            return Center(child: buildLoading());
          }

          if (state is ApplicationsError) {
            return Center(child: Text(state.message));
          }

          if (state is NoApplications) {
            return buildMessageContainer(message: 'No hay solicitudes');
          }

          if (state is ApplicationsLoaded) {
            if (widget.applications.isEmpty) {
              return buildMessageContainer(message: 'No hay solicitudes');
            } else {
              return ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: widget.applications.length,
                itemBuilder: (context, index) {
                  final application = widget.applications[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: _buildApplicationCard(context, application),
                  );
                },
              );
            }
          }

          return buildLoading();
        },
      ),
    );
  }

  // Card de la Solicitud
  Widget _buildApplicationCard(
      BuildContext context, ApplicationModel application) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: _buildCardDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildApplicationHeader(
                  context: context, application: application),
              SizedBox(height: 8),
              _builApplicationStatus(status: application.status),
              SizedBox(height: 8),
              _buildApplicationDate(
                applicationDate: application.applicationDate,
                typeOfDate: 'Fecha: ',
              ),
              if (application.status.toLowerCase() == 'aprobada') ...[
                SizedBox(height: 4),
                _buildApplicationDate(
                  applicationDate: application.applicationDate,
                  typeOfDate: 'Fecha de aprobación: ',
                ),
              ],
              SizedBox(height: 20),
              _buildApplicationDescription(
                description: application.description,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Apariencia del card
  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: AppConstants.primaryColor.withOpacity(0.08),
          spreadRadius: 2,
          blurRadius: 12,
          offset: Offset(3, 3),
        ),
      ],
    );
  }

  // Encabezado de la solicitud
  Widget _buildApplicationHeader(
      {required BuildContext context, required ApplicationModel application}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            application.type,
            style: const TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        if (application.status.toLowerCase() == "pendiente")
          Flexible(
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () => _showApplicationCancellationDialog(
                    context: context, application: application),
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

  // Fecha de la solicitud
  Widget _buildApplicationDate(
      {required DateTime applicationDate, required String typeOfDate}) {
    return Row(
      children: [
        Text(
          typeOfDate,
          style: TextStyle(
              color: AppConstants.primaryColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 2),
        Expanded(
          child: Text(
            DateFormat('dd/MM/yyyy, HH:mm').format(applicationDate),
            style: const TextStyle(
              color: AppConstants.primaryColor,
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Descripción de la solicitud
  Widget _buildApplicationDescription({required String description}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 255, 255, 255),
                  const Color.fromARGB(255, 247, 247, 247)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(
                color: AppConstants.primaryColor,
                width: 0.09,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              style: TextStyle(color: AppConstants.primaryColor, fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  // Estado de la Solicitud
  Widget _builApplicationStatus({required String status}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: AppConstants.tertiaryTxtColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              status,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppConstants.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Muestra el diálogo de cancelación
  void _showApplicationCancellationDialog(
      {required BuildContext context,
      required ApplicationModel application}) async {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CancellationDialog(
            onConfirm: () {
              BlocProvider.of<DeleteApplicationBloc>(context)
                  .add(DeleteApplicationEvent(applicationId: application.id));
            },
            title: 'Cancelar solicitud',
            description:
                '¿Está seguro de que desea cancelar la solicitud "${application.type}"?',
            actionBtnTitle: 'Confirmar');
      },
    );
  }
}
