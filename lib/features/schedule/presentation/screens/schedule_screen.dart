import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/data/models/schedule_model.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/features/schedule/domain/get_schedule_usecase.dart';
import 'package:uasd_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:uasd_app/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:uasd_app/features/schedule/presentation/bloc/schedule_state.dart';
import 'package:uasd_app/features/schedule/presentation/screens/detail_schedule_screen.dart';
import 'package:uasd_app/features/schedule/presentation/widgets/schedule_container.dart';
import 'package:uasd_app/injection_container.dart';

// Horarios
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ScheduleScreenState createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.tertiaryTxtColor,
      appBar: buildLightAppBar(title: 'Horario'),
      drawer: HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 4,
            ),
            _buildScheduleList(),
          ],
        ),
      ),
    );
  }

  // Lista de horarios
  Widget _buildScheduleList() {
    return Expanded(
      child: BlocProvider(
        create: (context) =>
            ScheduleBloc(scheduleUsecase: getIt<GetScheduleUsecase>())
              ..add(FetchSchedules()),
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading) {
              return buildLoading();
            } else if (state is ScheduleLoaded) {
              return _buildSchedules(state.schedules);
            } else if (state is ScheduleError) {
              return buildMessageContainer(message: state.message);
            } else {
              return buildMessageContainer(
                  message: 'Aún no tiene un horario definido.');
            }
          },
        ),
      ),
    );
  }

  // Se construye un grid con los horario
  _buildSchedules(List<ScheduleModel> schedules) => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12),
      scrollDirection: Axis.vertical,
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];

        return GestureDetector(
          onTap: () => _navigateToDetailScreen(context, schedule),
          child: ScheduleContainer(
            schedule: schedule,
          ),
        );
      });

  // func para navegar al detalle
  void _navigateToDetailScreen(BuildContext context, ScheduleModel schedule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScheduleScreen(schedule: schedule),
      ),
    );
  }
}
