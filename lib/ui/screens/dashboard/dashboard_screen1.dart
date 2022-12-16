import 'package:account_manager/repository/cash_transaction_repository.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/repository/currency_repository.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_screen.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_screen.dart';
import 'package:account_manager/ui/features/gst_calculator/gst_calculator.dart';
import 'package:account_manager/ui/screens/dashboard/dashboard_screen.dart';
import 'package:account_manager/ui/screens/dashboard/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:account_manager/route/route.dart' as route;
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/credit_debit/credit_debit_cubit.dart';
import '../../features/gst_calculator/gst_calculator_cubit.dart';

class DashboardScreen1 extends StatefulWidget {
  const DashboardScreen1({Key? key}) : super(key: key);

  @override
  State<DashboardScreen1> createState() => _DashboardScreen1State();
}

class _DashboardScreen1State extends State<DashboardScreen1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
          initialIndex: 2,

      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const TabBar(
              isScrollable: true,
              indicatorWeight: 3,
              labelColor: AppColors.primaryDarkest,
              indicatorColor: AppColors.primaryDarkest,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  icon: Icon(Icons.menu_rounded),
                  iconMargin: EdgeInsets.all(0),
                ),
                Tab(
                  text: AppStrings.calculator,
                ),
                Tab(
                  text: AppStrings.cashCounter,
                ),
                Tab(
                  text: AppStrings.creditDebit,
                ),

              ],
            ),
            const SizedBox(height: 8,),
            Expanded(
              child: TabBarView(
                children: [
                  const DashboardScreen(),
                  BlocProvider(
                    create: (context) => GstCalculatorCubit(),
                    child: const GstCalculator(),
                  ),
                  BlocProvider(
                    create: (context) => CashCounterCubit(
                        RepositoryProvider.of<CurrencyRepository>(context),
                        RepositoryProvider.of<CashTransactionRepository>(
                            context)),
                    child: const CashCounterScreen(),
                  ),
                  BlocProvider(
                    create: (context) => CreditDebitCubit(
                        RepositoryProvider.of<CreditDebitRepository>(context)),
                    child: const CreditDebitScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
