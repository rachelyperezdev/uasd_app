import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/customized_appBar.dart';
import 'package:uasd_app/core/widgets/launch_url.dart';
import 'package:uasd_app/core/widgets/messages_utils.dart';
import 'package:uasd_app/features/debt/presentation/widgets/debt_container.dart';
import 'package:uasd_app/core/widgets/header_image.dart';
import 'package:uasd_app/features/debt/domain/get_debts_usecase.dart';
import 'package:uasd_app/features/debt/presentation/bloc/debt_event.dart';
import 'package:uasd_app/features/debt/presentation/bloc/debt_state.dart';
import 'package:uasd_app/features/debt/presentation/bloc/debts_bloc.dart';
import 'package:uasd_app/features/home/presentation/widgets/home_drawer.dart';
import 'package:uasd_app/injection_container.dart';

class DebtsScreen extends StatefulWidget {
const DebtsScreen({super.key});
}

class DebtScreenState extends State<DebtsScreen> {
  final String imageUrl =
      'https://plus.unsplash.com/premium_photo-1676585567527-d25dbeec5b37?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

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
      body: _buildBody(screenHeight: screenHeight),
    );
  }

  // Construye el cuerpo
  Widget _buildBody({required double screenHeight}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderImage(
              imageUrl: imageUrl,
              height: screenHeight * 0.4,
              title: 'Deudas'.toUpperCase()),
          _buildGradientContainer(
            title1: "Deudas",
            title2: "Pendientes",
            buttonText: "Ir a la plataforma de pago",
            buttonUrl: AppConstants.paymentUrl,
          ),
          SizedBox(
            height: 16,
          ),
          _buildUnpaidDebts(),
          _buildGradientContainer(
            title1: "Deudas Pagas",
            title2: "",
            buttonText: "",
            buttonUrl: "",
          ),
          SizedBox(
            height: 16,
          ),
          _buildPaidDebts(),
          SizedBox(
            height: 42,
          )
        ],
      ),
    );
  }

  // Contenedor con gradiente
  Widget _buildGradientContainer({
    required String title1,
    required String title2,
    required String buttonText,
    required String buttonUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 222, 238, 255),
            const Color.fromARGB(255, 186, 218, 255)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1.toUpperCase(),
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (title2.isNotEmpty)
                  Text(
                    title2.toUpperCase(),
                    style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          if (buttonText.isNotEmpty) SizedBox(width: 8),
          if (buttonText.isNotEmpty)
            Flexible(
              child: _buildGradientButton(buttonText, buttonUrl),
            ),
        ],
      ),
    );
  }

  // Botón con gradiente
  Widget _buildGradientButton(String text, String url) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppConstants.bottomGradientColor, AppConstants.primaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          openUrl(context, url);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppConstants.tertiaryTxtColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Deudas pagadas
  Widget _buildPaidDebts() {
    return BlocProvider(
      create: (context) => DebtsBloc(getDebtsUsecase: getIt<GetDebtsUsecase>())
        ..add(FetchPaidDebtEvent()),
      child: BlocBuilder<DebtsBloc, DebtState>(builder: (context, state) {
        if (state is DebtsLoading) {
          return buildLoading();
        } else if (state is PaidDebtsLoaded && state.paidDebts.isNotEmpty) {
          return DebtContainer(debts: state.paidDebts);
        } else if (state is PaidDebtsError) {
          return buildMessageContainer(message: state.message);
        } else if (state is NoPaidDebts) {
          return buildMessageContainer(
              message: "No ha requerido pagar ninguna deuda.");
        } else {
          return buildMessageContainer(
              message: "No ha requerido pagar ninguna deuda.");
        }
      }),
    );
  }

  // Deudas sin pagar
  Widget _buildUnpaidDebts() {
    return BlocProvider(
      create: (context) => DebtsBloc(getDebtsUsecase: getIt<GetDebtsUsecase>())
        ..add(FetchUnpaidDebtEvent()),
      child: BlocBuilder<DebtsBloc, DebtState>(builder: (context, state) {
        if (state is DebtsLoading) {
          return buildLoading();
        } else if (state is UnpaidDebtsLoaded && state.unpaidDebts.isNotEmpty) {
          return DebtContainer(debts: state.unpaidDebts);
        } else if (state is UnpaidDebtsError) {
          return buildMessageContainer(message: state.message);
        } else if (state is NoUnpaidDebts) {
          return buildMessageContainer(message: "No tiene deudas pendientes.");
        } else {
          return buildMessageContainer(message: "No tiene deudas pendientes.");
        }
      }),
);
}
}
