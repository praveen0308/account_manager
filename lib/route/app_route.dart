import 'package:account_manager/features/calculator/emi_calculator/emi_calculator.dart';
import 'package:account_manager/features/cash_counter/cash_counter_screen.dart';
import 'package:account_manager/features/credit_debit/credit_debit_screen.dart';
import 'package:account_manager/features/gst_calculator/gst_calculator.dart';
import 'package:account_manager/features/gst_calculator/gst_calculator_cubit.dart';
import 'package:account_manager/features/income_expense/income_expense.dart';
import 'package:account_manager/screens/dashboard/dashboard_screen.dart';
import 'package:account_manager/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String splashScreen = '/';
const String dashboard = '/dashboard';
const String gstCalculator = '/gstCalculator';
const String cashCounter = '/cashCounter';
const String creditDebit = '/creditDebit';
const String emiCalculator = '/emiCalculator';
const String incomeExpense = '/incomeExpense';

Route<dynamic> controller(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(), settings: settings);
    case dashboard:
      return MaterialPageRoute(
          builder: (context) => const DashboardScreen(), settings: settings);
    case gstCalculator:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => GstCalculatorCubit(),
                child: const GstCalculator(),
              ),
          settings: settings);
    case cashCounter:
      return MaterialPageRoute(
          builder: (context) => const CashCounterScreen(), settings: settings);
    case creditDebit:
      return MaterialPageRoute(
          builder: (context) => const CreditDebitScreen(), settings: settings);
    case emiCalculator:
      return MaterialPageRoute(
          builder: (context) => const EmiCalculator(), settings: settings);
    case incomeExpense:
      return MaterialPageRoute(
          builder: (context) => const IncomeExpenseScreen(),
          settings: settings);
    default:
      throw ('this route name does not exist');
  }
}
