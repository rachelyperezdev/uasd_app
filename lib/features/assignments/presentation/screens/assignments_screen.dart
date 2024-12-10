import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/gradient_container.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
import 'package:uasd_app/core/widgets/launch_url.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/data/models/assignment_model.dart';
import 'package:uasd_app/features/assignments/domain/get_assignments_usecase.dart';
import 'package:uasd_app/features/assignments/presentation/bloc/assignment_event.dart';
import 'package:uasd_app/features/assignments/presentation/bloc/assignment_state.dart';
import 'package:uasd_app/features/assignments/presentation/bloc/assignments_bloc.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/injection_container.dart';

class AssignmentsScreen extends StatefulWidget {
  AssignmentsScreen({super.key});

  @override
  AssignmentsScreenState createState() => AssignmentsScreenState();
}

class AssignmentsScreenState extends State<AssignmentsScreen>
    with SingleTickerProviderStateMixin {
  late CarouselSliderController innerCarouselController;
  int innerCurrentPage = 0;

  @override
  void initState() {
    innerCarouselController = CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppConstants.primaryBgColor,
      extendBodyBehindAppBar: true,
      appBar: buildTransparentAppBar(iconColor: AppConstants.primaryColor),
      drawer: HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                height: size.height * 0.4,
                title: 'Tareas'.toUpperCase()),
            buildGradientContainer(title1: 'Próximos', title2: 'Vencimientos'),
            _buildLatestPendingAssignments(
                height: size.height, width: size.width),
            buildGradientContainer(title1: "Tareas", title2: "Pendientes"),
            _buildPendingAssignments(height: size.height * 0.3),
            buildGradientContainer(title1: "Tareas", title2: "Completadas"),
            _buildCompletedAssignments(height: size.height * 0.3),
            buildGradientContainer(title1: "Todas", title2: ""),
            _buildAssignments(height: size.height * 0.3),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Todas las tareas
  Widget _buildAssignments({required double height}) {
    return BlocProvider(
      create: (context) =>
          AssignmentsBloc(assignmentsUsecase: getIt<GetAssignmentsUsecase>())
            ..add(FetchAssignments()),
      child: BlocBuilder<AssignmentsBloc, AssignmentState>(
          builder: (context, state) {
        if (state is AssignmentLoading) {
          return buildLoading();
        } else if (state is AssignmentsLoaded && state.assignments.isNotEmpty) {
          return buildGrid(assignments: state.assignments, height: height);
        } else if (state is AssignmentsError) {
          return buildMessageContainer(message: state.message);
        } else if (state is NoAssignments) {
          return buildMessageContainer(message: "No tiene tareas");
        } else {
          return buildMessageContainer(message: "No tiene tareas");
        }
      }),
    );
  }

  // Tareas completadas
  Widget _buildCompletedAssignments({required double height}) {
    return BlocProvider(
      create: (context) =>
          AssignmentsBloc(assignmentsUsecase: getIt<GetAssignmentsUsecase>())
            ..add(FetchCompletedAssignments()),
      child: BlocBuilder<AssignmentsBloc, AssignmentState>(
          builder: (context, state) {
        if (state is AssignmentLoading) {
          return buildLoading();
        } else if (state is CompletedAssignmentsLoaded &&
            state.completedAssignments.isNotEmpty) {
          return buildGrid(
              assignments: state.completedAssignments, height: height);
        } else if (state is CompletedAssignmentsError) {
          return buildMessageContainer(message: state.message);
        } else if (state is NoPendingAssignments) {
          return buildMessageContainer(message: "No tiene tareas completadas");
        } else {
          return buildMessageContainer(message: "No tiene tareas completadas");
        }
      }),
    );
  }

  // Próximos vencimientos
  Widget _buildLatestPendingAssignments(
      {required double height, required double width}) {
    return BlocProvider(
      create: (context) =>
          AssignmentsBloc(assignmentsUsecase: getIt<GetAssignmentsUsecase>())
            ..add(FetchPendingAssignments()),
      child: BlocBuilder<AssignmentsBloc, AssignmentState>(
          builder: (context, state) {
        if (state is AssignmentLoading) {
          return buildLoading();
        } else if (state is PendingAssignmentsLoaded &&
            state.pendingAssignments.isNotEmpty) {
          return _innerBannerSlider(
              assignments: state.pendingAssignments,
              height: width,
              width: width);
        } else if (state is PendingAssignmentsError) {
          return buildMessageContainer(message: state.message);
        } else if (state is NoPendingAssignments) {
          return buildMessageContainer(message: "No tiene tareas pendientes");
        } else {
          return buildMessageContainer(message: "No tiene tareas pendientes");
        }
      }),
    );
  }

  // Tareas pendientes
  Widget _buildPendingAssignments({required double height}) {
    return BlocProvider(
      create: (context) =>
          AssignmentsBloc(assignmentsUsecase: getIt<GetAssignmentsUsecase>())
            ..add(FetchPendingAssignments()),
      child: BlocBuilder<AssignmentsBloc, AssignmentState>(
          builder: (context, state) {
        if (state is AssignmentLoading) {
          return buildLoading();
        } else if (state is PendingAssignmentsLoaded &&
            state.pendingAssignments.isNotEmpty) {
          return buildGrid(
              assignments: state.pendingAssignments, height: height);
        } else if (state is PendingAssignmentsError) {
          return buildMessageContainer(message: state.message);
        } else if (state is NoPendingAssignments) {
          return buildMessageContainer(message: "No tiene tareas pendientes");
        } else {
          return buildMessageContainer(message: "No tiene tareas pendientes");
        }
      }),
    );
  }

  // Recordartorios de las últimas tres tareas con un inner banner slider
  Widget _innerBannerSlider(
      {required List<AssignmentModel> assignments,
      required double height,
      required double width}) {
    double sliderHeight = width > 1200 ? 400.0 : height * 0.7;

    assignments.sort((a, b) => b.dueDate.compareTo(a.dueDate));
    final recentAssignments =
        assignments.take(3).toList(); // determina las tres
    // tareas próximo a vencer

    return Column(
      children: [
        SizedBox(
          height: sliderHeight,
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: CarouselSlider(
                  carouselController: innerCarouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    aspectRatio: 16 / 8,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        innerCurrentPage = index;
                      });
                    },
                  ),
                  items: recentAssignments.map((assignment) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            openUrl(context, AppConstants.moodleUrl);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 250, 251, 252),
                                  const Color.fromARGB(255, 245, 248, 252),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: AppConstants.primaryColor
                                      .withOpacity(0.08),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    assignment.title,
                                    style: TextStyle(
                                      color: AppConstants.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Vencimiento: ',
                                        style: TextStyle(
                                            color: AppConstants.primaryTxtColor
                                                .withOpacity(0.5),
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        DateFormat('dd/MM/yyyy, HH:mm')
                                            .format(assignment.dueDate),
                                        style: TextStyle(
                                            color: AppConstants.primaryColor,
                                            fontSize: 16),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Grid donde se mostrarán las tareas
  Widget buildGrid({
    required List<AssignmentModel> assignments,
    required double height,
  }) {
    return Container(
      color: const Color.fromARGB(255, 239, 247, 253),
      padding: EdgeInsets.all(16.0),
      child: SizedBox(
        height: height * 1.2,
        child: GridView.builder(
          itemCount: assignments.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          padding: const EdgeInsets.all(4.0),
          itemBuilder: (context, index) {
            return buildCard(assignments[index]);
          },
        ),
      ),
    );
  }

  // Card de las tareas
  Widget buildCard(AssignmentModel assignment) {
    return InkWell(
      onTap: () {
        openUrl(context, AppConstants.moodleUrl);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 237, 245, 255),
                const Color.fromARGB(255, 237, 245, 255),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryColor.withOpacity(0.08),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment.title,
                  style: const TextStyle(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  DateFormat('dd/MM/yyyy, HH:mm').format(assignment.dueDate),
                  style: TextStyle(
                      color: const Color.fromARGB(255, 177, 62, 0),
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Image.network(
                      'https://icons-for-free.com/iff/png/512/moodle+original-1324760553332955087.png',
                      height: 18,
                      width: 18,
                    )),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: const Color.fromARGB(255, 230, 241, 255),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Text(
                          'TAREA',
                          style: TextStyle(color: AppConstants.primaryColor),
                        ),
                        Text(assignment.description)
                      ],
                    )),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

