import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/income_expense/income_expense_model.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/repository/cash_transaction_repository.dart';
import 'package:account_manager/repository/category_repository.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/repository/currency_repository.dart';
import 'package:account_manager/repository/income_expense_repository.dart';
import 'package:account_manager/ui/features/calculator/calculator.dart';
import 'package:account_manager/ui/features/calculator/emi_calculator/emi_calculator.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_screen.dart';
import 'package:account_manager/ui/features/cash_counter/history/cc_history_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/history/cc_history_screen.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_screen.dart';
import 'package:account_manager/ui/features/credit_debit/edit_transaction/edit_cd_transaction.dart';
import 'package:account_manager/ui/features/credit_debit/edit_transaction/edit_cd_transaction_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/edit_transaction/select_person/select_person.dart';
import 'package:account_manager/ui/features/credit_debit/edit_transaction/select_person/select_person_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_screen.dart';
import 'package:account_manager/ui/features/gst_calculator/gst_calculator.dart';
import 'package:account_manager/ui/features/gst_calculator/gst_calculator_cubit.dart';
import 'package:account_manager/ui/features/income_expense/add_income_expense/add_income_expense.dart';
import 'package:account_manager/ui/features/income_expense/add_income_expense/add_income_expense_cubit.dart';
import 'package:account_manager/ui/features/income_expense/category/add_category/add_category_cubit.dart';
import 'package:account_manager/ui/features/income_expense/category/category_detail/category_detail_cubit.dart';
import 'package:account_manager/ui/features/income_expense/category/category_detail/category_detail_screen.dart';
import 'package:account_manager/ui/features/income_expense/edit_income_expense/edit_income_expense_screen.dart';
import 'package:account_manager/ui/features/income_expense/income_expense_parent_cubit.dart';
import 'package:account_manager/ui/features/income_expense/income_expense_screen.dart';
import 'package:account_manager/ui/features/income_expense/pick_category/pick_category.dart';
import 'package:account_manager/ui/features/income_expense/pick_category/pick_category_cubit.dart';
import 'package:account_manager/ui/screens/dashboard/dashboard_screen.dart';
import 'package:account_manager/ui/screens/dashboard/dashboard_screen1.dart';
import 'package:account_manager/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/income_expense/category_model.dart';
import '../ui/features/cash_counter/edit_cash_transaction/edit_cash_transaction.dart';
import '../ui/features/cash_counter/edit_cash_transaction/edit_cash_transaction_cubit.dart';
import '../ui/features/income_expense/category/add_category/add_category_screen.dart';
import '../ui/features/income_expense/edit_income_expense/edit_income_expense_cubit.dart';
import '../utils/income_type.dart';

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
const String addCategory = '/addCategory';
const String addIncomeExpense = '/addIncomeExpense';
const String pickCategory = '/pickCategory';
const String editCashTransaction = '/editCashTransaction';
const String editIncomeExpenseTransaction = '/editIncomeExpenseTransaction';
const String editCDTransaction = '/editCDTransaction';
const String categoryDetail = '/categoryDetail';
const String selectPerson = '/selectPerson';

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
                    RepositoryProvider.of<CashTransactionRepository>(context)),
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
          builder: (context) => const MainCalculator(), settings: settings);
    case incomeExpense:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => IncomeExpenseParentCubit(
                    RepositoryProvider.of<IncomeExpenseRepository>(context)),
                child: const IncomeExpenseScreen(),
              ),
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
    case addCategory:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => AddCategoryCubit(
                    RepositoryProvider.of<CategoryRepository>(context)),
                child: const AddCategoryScreen(),
              ),
          settings: settings);
    case addIncomeExpense:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => AddIncomeExpenseCubit(
                    RepositoryProvider.of<IncomeExpenseRepository>(context)),
                child: AddIncomeExpense(args: args as AddIncomeExpenseArgs),
              ),
          settings: settings);
    case pickCategory:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => PickCategoryCubit(
                    RepositoryProvider.of<CategoryRepository>(context)),
                child: PickCategory(type: args as IncomeType),
              ),
          settings: settings);
    case editCashTransaction:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => EditCashTransactionCubit(
                    RepositoryProvider.of<CashTransactionRepository>(context)),
                child: EditCashTransactionScreen(
                    transaction: args as CashTransactionModel),
              ),
          settings: settings);

    case editIncomeExpenseTransaction:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => EditIncomeExpenseCubit(
                    RepositoryProvider.of<IncomeExpenseRepository>(context)),
                child: EditIncomeExpenseScreen(
                    transaction: args as IncomeExpenseModel),
              ),
          settings: settings);
    case editCDTransaction:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => EditCdTransactionCubit(
                    RepositoryProvider.of<CreditDebitRepository>(context)),
                child: EditCDTransaction(args: args as EditCDTransactionArgs),
              ),
          settings: settings);

    case categoryDetail:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => CategoryDetailCubit(
                    RepositoryProvider.of<CategoryRepository>(context)),
                child: CategoryDetailScreen(category: args as CategoryModel),
              ),
          settings: settings);

    case selectPerson:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => SelectPersonCubit(
                    RepositoryProvider.of<CreditDebitRepository>(context)),
                child: SelectPersonScreen(args: args as SelectPersonArgs),
              ),
          settings: settings);

    default:
      throw ('this route name does not exist');
  }
}
