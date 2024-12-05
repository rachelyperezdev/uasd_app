import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/gradient_container.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/data/models/preselection_model.dart';
import 'package:uasd_app/features/preselection/domain/get_preselections_usecase.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/get_preselection/preselection_bloc.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/get_preselection/preselection_event.dart';
import 'package:uasd_app/features/preselection/presentation/bloc/preselection/get_preselection/preselection_state.dart';
import 'package:uasd_app/features/preselection/presentation/widgets/preselection_container.dart';
import 'package:uasd_app/injection_container.dart';

// Pantalla de los Estados de la Preselección
class PreselectionStatusScreen extends StatefulWidget {
  PreselectionStatusScreen({super.key});

  @override
  PreselectionStatusScreenState createState() =>
      PreselectionStatusScreenState();
}

class PreselectionStatusScreenState extends State<PreselectionStatusScreen> {
  List<PreselectionModel> confirmedPreselection =
      []; // preselecciones confirmadas
  List<PreselectionModel> unconfirmedPreselection =
      []; // preselecciones sin confirmar

  @override
  void initState() {
    super.initState();
    _fetchConfirmedPreselection(); // las carga
    _fetchUnconfirmedPreselection();
  }

  // Busca las preselecciones confirmadas
  Future<void> _fetchConfirmedPreselection() async {
    final result =
        await getIt<GetPreselectionsUsecase>().callConfirmedPreselection();
    result.fold(
      (failure) => print('Fallo fetching de asignaturas confirmadas'),
      (fetchedConfirmedPreselection) {
        setState(() {
          confirmedPreselection = fetchedConfirmedPreselection;
        });
      },
    );
  }

  // Busca las preselecciones no confirmadas
  Future<void> _fetchUnconfirmedPreselection() async {
    final result =
        await getIt<GetPreselectionsUsecase>().callUnconfirmedPreselection();
    result.fold(
      (failure) => print('Fallo fetching de asignaturas no confirmadas'),
      (fetchedUnconfirmedPreselection) {
        setState(() {
          unconfirmedPreselection = fetchedUnconfirmedPreselection;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppConstants.primaryBgColor,
      extendBodyBehindAppBar: true,
      appBar: buildTransparentAppBar(iconColor: AppConstants.primaryColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderImage(
                imageUrl:
                    'https://images.pexels.com/photos/8850706/pexels-photo-8850706.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                height: size.height * 0.4,
                title: 'Mi Preselección'.toUpperCase()),
            buildGradientContainer(title1: 'Confirmadas', title2: ''),
            _buildConfirmedPreselection(height: size.height * 0.3),
            buildGradientContainer(title1: 'Pendientes', title2: ''),
            SizedBox(
              height: 16,
            ),
            _buildUnconfirmedPreselection(height: size.height * 0.3),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Preselecciones confirmadas
  Widget _buildConfirmedPreselection({required double height}) {
    return BlocProvider(
      create: (context) => PreselectionBloc(
          preselectionsUsecase: getIt<GetPreselectionsUsecase>())
        ..add(FetchConfirmedPreselection()),
      child: BlocBuilder<PreselectionBloc, PreselectionState>(
          builder: (context, state) {
        if (state is PreselectionLoading) {
          return buildLoading();
        } else if (state is ConfirmedPreselectionError) {
          return buildMessageContainer(message: state.message);
        } else if (state is NoConfirmedPreselection) {
          return buildMessageContainer(
              message:
                  'No tiene asignaturas confirmadas para su preselección.');
        } else if (state is ConfirmedPreselectionLoaded) {
          return ConfirmedPreselectionContainer(
            preselection: state.confirmedPreselection,
            refreshConfirmedPreselection: _fetchConfirmedPreselection,
          );
        } else {
          return buildMessageContainer(
              message:
                  'No tiene asignaturas confirmadas para su preselección.');
        }
      }),
    );
  }

  // Preselecciones pendientes
  Widget _buildUnconfirmedPreselection({required double height}) {
    return BlocProvider(
      create: (context) => PreselectionBloc(
          preselectionsUsecase: getIt<GetPreselectionsUsecase>())
        ..add(FetchUnconfirmedPreselection()),
      child: BlocBuilder<PreselectionBloc, PreselectionState>(
          builder: (context, state) {
        if (state is PreselectionLoading) {
          return buildLoading();
        } else if (state is UnconfirmedPreselectionError) {
          return buildMessageContainer(message: state.message);
        } else if (state is NoConfirmedPreselection) {
          return buildMessageContainer(
              message:
                  'No tiene asignaturas sin confirmar para su preselección.');
        } else if (state is UnconfirmedPreselectionLoaded) {
          return UnconfirmedPreselectionContainer(
            preselection: state.unconfirmedPreselection,
            refreshUnconfirmedPreselection: _fetchUnconfirmedPreselection,
          );
        } else {
          return buildMessageContainer(
              message:
                  'No tiene asignaturas sin confirmar para su preselección.');
        }
      }),
    );
  }
}
