import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uasd_app/app/app_constants.dart';
import 'package:uasd_app/core/widgets/circular_progress_indicator.dart';
import 'package:uasd_app/core/widgets/launch_url.dart';
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

  @override
  DebtScreenState createState() => DebtScreenState();
}

class DebtScreenState extends State<DebtsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: AppConstants.primaryBgColor,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      drawer: HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderImage(
                imageUrl:
                    'https://plus.unsplash.com/premium_photo-1676585567527-d25dbeec5b37?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppConstants.primaryColor, size: 30.0),
    );
  }

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
          return _buildError(state.message);
        } else if (state is NoPaidDebts) {
          return _buildNoDebts(message: "No ha requerido pagar ninguna deuda.");
        } else {
          return _buildNoDebts(message: "No ha requerido pagar ninguna deuda.");
        }
      }),
    );
  }

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
          return _buildError(state.message);
        } else if (state is NoUnpaidDebts) {
          return _buildNoDebts(message: "No tiene deudas pendientes.");
        } else {
          return _buildNoDebts(message: "No tiene deudas pendientes.");
        }
      }),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: AppConstants.primaryTxtColor,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildNoDebts({required String message}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
              top: BorderSide(color: AppConstants.primaryColor, width: 0.2),
              bottom: BorderSide(color: AppConstants.primaryColor, width: 0.2),
              right: BorderSide(color: AppConstants.primaryColor, width: 0.2),
              left: BorderSide(color: AppConstants.primaryColor, width: 0.2)),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 232, 243, 255),
              const Color.fromARGB(255, 225, 239, 255)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.primaryColor.withOpacity(0.08),
              spreadRadius: 4,
              blurRadius: 12,
              offset: Offset(3, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.info,
              color: AppConstants.primaryColor,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: AppConstants.primaryColor,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
