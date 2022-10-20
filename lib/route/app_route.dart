import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/repository/cash_transaction_repository.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/repository/currency_repository.dart';
import 'package:account_manager/ui/features/calculator/emi_calculator/emi_calculator.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_screen.dart';
import 'package:account_manager/ui/features/cash_counter/history/cc_history_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/history/cc_history_screen.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_screen.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_screen.dart';
import 'package:account_manager/ui/features/gst_calculator/gst_calculator.dart';
import 'package:account_manager/ui/features/gst_calculator/gst_calculator_cubit.dart';
import 'package:account_manager/ui/features/income_expense/income_expense_screen.dart';
import 'package:account_manager/ui/screens/dashboard/dashboard_screen.dart';
import 'package:account_manager/ui/screens/dashboard/dashboard_screen1.dart';
import 'package:account_manager/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String splashScreen = '/';
const String dashboard = '/dashboard';
const String dashboard1 = '/dashboard1';
const String gstCalculator = '/gstCalculator';
const String cashCounter = '/cashCounter';
const String cashCounterHistory = '/cashCounterHistory';
const String creditDebit = '/creditDebit';
const String emiCalculator = '/emiCalculator';
const String incomeExpense = '/incomeExpense';
const String cdHistory = '/cdHistory';

Route<dynamic> controller(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(), settings: settings);
    case dashboard:
      return MaterialPageRoute(
          builder: (context) => const DashboardScreen(), settings: settings);
    case dashboard1:
      return MaterialPageRoute(
          builder: (context) => const DashboardScreen1(), settings: settings);
    case gstCalculator:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => GstCalculatorCubit(),
                child: const GstCalculator(),
              ),
          settings: settings);
    case cashCounter:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CashCounterCubit(
                RepositoryProvider.of<CurrencyRepository>(context),
                RepositoryProvider.of<CashTransactionRepository>(
                    context)),
            child: const CashCounterScreen(),
          ),
          settings: settings);
    case creditDebit:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => CreditDebitCubit(
                    RepositoryProvider.of<CreditDebitRepository>(context)),
                child: const CreditDebitScreen(),
              ),
          settings: settings);
    case emiCalculator:
      return MaterialPageRoute(
          builder: (context) => const EmiCalculator(), settings: settings);
    case incomeExpense:
      return MaterialPageRoute(
          builder: (context) => const IncomeExpenseScreen(),
          settings: settings);
    case cdHistory:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => CdHistoryCubit(
                    RepositoryProvider.of<CreditDebitRepository>(context)),
                child: CDHistory(person: args as PersonModel),
              ),
          settings: settings);

    case cashCounterHistory:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => CcHistoryCubit(
                    RepositoryProvider.of<CashTransactionRepository>(context)),
                child: const CCHistoryScreen(),
              ),
          settings: settings);
    default:
      throw ('this route name does not exist');
  }
}
