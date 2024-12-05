import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/features/events/domain/get_events_usecase.dart';
import 'package:uasd_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:uasd_app/features/events/presentation/bloc/events_event.dart';
import 'package:uasd_app/features/events/presentation/bloc/events_state.dart';
import 'package:uasd_app/features/events/presentation/widgets/events_list_widget.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/injection_container.dart';

class EventsScreen extends StatefulWidget {
const EventsScreen({super.key});
}

class EventsScreenState extends State<EventsScreen> {
  final String imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5nEYP0f1WdUHNrp0OZBsD8SfiVQc-jXP0JA&s';
@override
void initState() {
super.initState();
}

@override
Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

return Scaffold(
      // backgroundColor: ,
      // appBar: ,
      // drawer: ,
      body: Center(),
      backgroundColor: AppConstants.primaryBgColor,
      extendBodyBehindAppBar: true,
      appBar: buildTransparentAppBar(iconColor: AppConstants.primaryColor),
      drawer: HomeDrawer(),
      body: Column(
        children: [
          HeaderImage(
              imageUrl: imageUrl,
              height: screenHeight * 0.4,
              title: 'Eventos'.toUpperCase()),
          _buildEventsList(),
        ],
      ),
    );
  }

  Widget _buildEventsList() {
    return Expanded(
      child: BlocProvider(
        create: (context) =>
            EventsBloc(eventsUsecase: getIt<GetEventsUsecase>())
              ..add(FetchEvents()),
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            if (state is EventsLoading) {
              return buildLoading();
            } else if (state is EventsLoaded) {
              return EventsListWidget(eventsList: state.events);
            } else if (state is EventsError) {
              return buildMessageContainer(message: state.message);
            } else {
              return buildMessageContainer(
                  message: 'No hay eventos disponibles');
            }
          },
        ),
      ),
);
}
}
