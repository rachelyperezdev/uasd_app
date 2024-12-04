import 'package:flutter/material.dart';

// Constantes de la aplicación
class AppConstants {
  // URL
  static const String baseUrl = 'https://uasdapi.ia3x.com';

  // Payment URL
  static const String paymentUrl =
      'https://uasd.edu.do/servicios/pago-en-linea/';

  // Moodle URL
  static const String moodleUrl = 'https://moodle.org/?lang=es';

  // App
  static const String appTitle = 'UASD';
  static const String universityName = 'Universidad Autónoma De Santo Domingo';

  // Screens
  static const List<String> screens = [
    'Inicio',
    'Información del Usuario',
    'Noticias',
    'Horario',
    'Preselección',
    'Deudas',
    'Solicitudes',
    'Mis Tareas',
    'Eventos',
    'Videos',
    'Sobre los Desarrolladores',
    'Cerrar Sesión'
  ];

  // Screen icons
  static const Map<String, IconData> screenIcons = {
    'Inicio': Icons.home,
    'Información del Usuario': Icons.person,
    'Noticias': Icons.article,
    'Horario': Icons.schedule,
    'Preselección': Icons.select_all,
    'Deudas': Icons.attach_money,
    'Solicitudes': Icons.card_membership,
    'Mis Tareas': Icons.assignment,
    'Eventos': Icons.event,
    'Videos': Icons.video_library,
    'Sobre los Desarrolladores': Icons.info,
    'Cerrar Sesión': Icons.logout,
  };

  // Routes
  static const Map<String, String> screenRoutes = {
    'Inicio': AppConstants.homeRoute,
    'Información del Usuario': AppConstants.aboutUserRoute,
    'Noticias': AppConstants.newsRoute,
    'Horario': AppConstants.scheduleRoute,
    'Preselección': AppConstants.preselectionRoute,
    'Deudas': AppConstants.debtsRoute,
    'Solicitudes': AppConstants.applicationsRoute,
    'Mis Tareas': AppConstants.assignmentsRoute,
    'Eventos': AppConstants.eventsRoute,
    'Videos': AppConstants.videosRoute,
    'Sobre los Desarrolladores': AppConstants.aboutDevelopersRoute,
    'Cerrar Sesión': AppConstants.landingRoute,
  };

  // Page Routes
  static const String initialRoute = '/';
  static const String aboutDevelopersRoute = 'about_developers';
  static const String aboutUserRoute = '/about_user';
  static const String addApplicationRoute = '/addApplication';
  static const String applicationsRoute = '/applications';
  static const String assignmentsRoute = '/assignments';
  static const String debtsRoute = '/debts';
  static const String eventsRoute = '/events';
  static const String userInfoRoute = '/info_usuario';
  static const String homeRoute = '/home';
  static const String landingRoute = '/landing';
  static const String loginRoute = '/login';
  static const String newsRoute = '/news';
  static const String preselectionRoute = '/preselection';
  static const String preselectionStatusRoute = '/preselection_status';
  static const String resetPasswordRoute = '/reset_password';
  static const String scheduleRoute = '/schedule';
  static const String videosRoute = '/videos';

  // Main Functionalities (home)
  static const Map<String, dynamic> mainFunctionalities = {
    'Noticias': {"icon": Icons.article, "route": AppConstants.newsRoute},
    'Horario': {"icon": Icons.schedule, "route": AppConstants.scheduleRoute},
    'Preselección': {
      "icon": Icons.select_all,
      "route": AppConstants.preselectionRoute
    },
    'Deudas': {"icon": Icons.attach_money, "route": AppConstants.debtsRoute},
    'Solicitudes': {
      "icon": Icons.card_membership,
      "route": AppConstants.applicationsRoute
    },
    'Mis Tareas': {
      "icon": Icons.assignment,
      "route": AppConstants.assignmentsRoute
    },
    'Eventos': {"icon": Icons.event, "route": AppConstants.eventsRoute},
    'Videos': {"icon": Icons.video_library, "route": AppConstants.videosRoute},
  };

  // Colors
  static const Color primaryColor = Color.fromARGB(255, 2, 103, 219);
  static const Color secondaryColor = Color.fromARGB(255, 96, 170, 255);
  static const Color primaryTxtColor = Color.fromARGB(255, 0, 73, 156);
  static const Color tertiaryTxtColor = Color.fromARGB(255, 227, 240, 255);
  static const Color quaternaryTxtColor = Color.fromARGB(255, 201, 214, 229);
  static const Color errorTxtColor = Colors.red;
  static const Color primaryBgColor = Color.fromARGB(255, 235, 242, 252);
  static const Color bottomGradientColor = Color.fromARGB(255, 31, 136, 255);

  // Info - Landing Screen
  static const String aboutUASD =
      "La Universidad Autónoma de Santo Domingo (UASD) es una universidad pública en la República Dominicana. Fundada en 1538, es la primera universidad estatal del país y una de las más antiguas de América. Su sede principal está en Santo Domingo, pero también tiene recintos y centros en varias provincias.";

  static const String missionUASD =
      "Su Misión es formar críticamente profesionales, investigadores y técnicos en las ciencias, las humanidades y las artes necesarias y eficientes para coadyuvar a las transformaciones que demanda el desarrollo nacional sostenible, así como difundir los ideales de la cultura de paz, progreso, justicia social, equidad de género y respeto a los derechos humanos, a fin de contribuir a la formación de una conciencia colectiva basada en valores.";

  static const String visionUASD =
      "La Universidad tiene como Visión ser una institución de excelencia y liderazgo académico, gestionada con eficiencia y acreditada nacional e internacionalmente; con un personal docente, investigador, extensionistas y egresados de alta calificación; creadora de conocimientos científicos y nuevas tecnologías, y reconocida por su contribución al desarrollo humano con equidad y hacia una sociedad democrática y solidaria.";

  static const List<String> valuesUASD = [
    'Solidaridad',
    'Transparencia',
    'Verdad',
    'Igualdad',
    'Libertad',
    'Equidad',
    'Tolerancia',
    'Responsabilidad',
    'Convivencia',
    'Paz'
  ];

  static const List<String> imagesUASD = [
    'https://uasd.edu.do/wp-content/uploads/UASD-13.jpg',
    'https://media.acento.com.do/media/storage02/uploads/2020/09/UASD-1.jpg',
    'https://uasd.edu.do/wp-content/uploads/2021/01/aula_magna2.png',
    'https://www.eljaya.com/wp-content/uploads/2023/09/3-Mural-Raices.jpg',
    'https://jornadacientifica.uasd.edu.do/wp-content/uploads/2023/10/pedro-mir.jpg',
    'https://guiavisual.net/IM001547a.JPG',
    'https://resumendesalud.net/wp-content/uploads/2022/06/UASD-2.jpg',
    'https://hoy.com.do/wp-content/uploads/2022/08/6_El-Pais_20_1p02.jpg',
    'https://m.psecn.photoshelter.com/img-get/I0000iFX1LdARlpw/s/750/750/Edificio-Administrativo-UASD-2.jpg'
  ];

  // About Developers
  static const List<Map<String, String>> developers = [
    {
      "name": "Alexander Hilario",
      "tuition": "2022-1927",
      "img": "assets/images/alexander.png",
    },
    {
      "name": "Héctor Medina",
      "tuition": "2022-2045",
      "img": "assets/images/hector.png",
    },
    {
      "name": "Rachely Pérez",
      "tuition": "2022-1856",
      "img": "assets/images/rachely.png",
    },
  ];
}
