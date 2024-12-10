import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/data/models/application_model.dart';
import 'package:uasd_app/features/applications/domain/application_usecase.dart';
import 'package:uasd_app/features/applications/presentation/bloc/add_application/add_application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/application_types/application_types_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/application_types/application_types_event.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_bloc.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_event.dart';
import 'package:uasd_app/features/applications/presentation/bloc/applications/application_state.dart';
import 'package:uasd_app/features/applications/presentation/screens/add_application_screen.dart';
import 'package:uasd_app/features/applications/presentation/widgets/application_list_widget.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/injection_container.dart';

class ApplicationsScreen extends StatefulWidget {
  ApplicationsScreen({super.key});

  @override
  ApplicationsScreenState createState() => ApplicationsScreenState();
}

class ApplicationsScreenState extends State<ApplicationsScreen> {
  List<ApplicationModel> applications = [];

  @override
  void initState() {
    super.initState();
    _fetchApplications();
  }

  // Busca las Solicitudes
  Future<void> _fetchApplications() async {
    final result = await getIt<ApplicationUsecase>().getApplications();
    result.fold(
      (failure) => print('Fallo fetching solicitudes'),
      (fetchedApplications) {
        setState(() {
          applications = fetchedApplications;
        });
      },
    );
  }

  // Remueve las Solicitudes
  Future<void> _removeApplication(ApplicationModel application) async {
    setState(() {
      applications.remove(application);
    });

    await getIt<ApplicationUsecase>()
        .deleteApplication(applicationId: application.id);

    await _fetchApplications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryBgColor,
      extendBodyBehindAppBar: true,
      appBar: buildTransparentAppBar(),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  // Sidemenu
  Widget _buildDrawer(BuildContext context) {
    return HomeDrawer();
  }

  // Construye el cuerpo
  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        HeaderImage(
          imageUrl:
              'https://plus.unsplash.com/premium_photo-1681487591275-4c38e89b1d5e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          height: size.height * 0.4,
          title: 'Mis Solicitudes'.toUpperCase(),
        ),
        Expanded(
          child: BlocProvider(
            create: (context) => ApplicationBloc(
              applicationUsecase: getIt<ApplicationUsecase>(),
            )..add(FetchApplications()),
            child: BlocBuilder<ApplicationBloc, ApplicationState>(
              builder: (context, state) {
                if (state is ApplicationLoading) {
                  return buildLoading();
                } else if (state is ApplicationsLoaded) {
                  return ApplicationListWidget(
                    applications: state.applications,
                    refreshApplications: _fetchApplications,
                    onDelete: _removeApplication,
                  );
                } else if (state is ApplicationsError) {
                  return buildMessageContainer(message: state.message);
                } else if (state is NoApplications) {
                  return buildMessageContainer(
                      message: 'No hay solicitudes existentes');
                } else {
                  return buildMessageContainer(
                      message: 'No hay solicitudes existentes');
                }
              },
            ),
          ),
        )
      ],
    );
  }

  // Botón para añadir solicitudes
  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppConstants.primaryColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ApplicationTypesBloc(
                applicationUsecase: getIt<ApplicationUsecase>(),
              )..add(FetchApplicationTypes()),
              child: BlocProvider(
                create: (context) => AddApplicationBloc(
                  applicationUsecase: getIt<ApplicationUsecase>(),
                ),
                child: AddApplicationScreen(),
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.add,
        color: AppConstants.tertiaryTxtColor,
      ),
    );
  }
}