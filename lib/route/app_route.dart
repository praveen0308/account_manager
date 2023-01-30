import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/income_expense/income_expense_model.dart';
import 'package:account_manager/models/note_model.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/repository/cash_transaction_repository.dart';
import 'package:account_manager/repository/category_repository.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/repository/currency_repository.dart';
import 'package:account_manager/repository/income_expense_repository.dart';
import 'package:account_manager/repository/note_repository.dart';
import 'package:account_manager/ui/features/backup_restore/backup_restore.dart';
import 'package:account_manager/ui/features/backup_restore/backup_restore_cubit.dart';
import 'package:account_manager/ui/features/business_report/business_report_screen.dart';
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
import 'package:account_manager/ui/features/lock_screen/create_pin/create_pin.dart';
import 'package:account_manager/ui/features/lock_screen/create_pin/create_pin_cubit.dart';
import 'package:account_manager/ui/features/lock_screen/forgot_password/forgot_password.dart';
import 'package:account_manager/ui/features/lock_screen/forgot_password/forgot_password_cubit.dart';
import 'package:account_manager/ui/features/lock_screen/pin_authentication/pin_authentication.dart';
import 'package:account_manager/ui/features/lock_screen/pin_authentication/pin_authentication_cubit.dart';
import 'package:account_manager/ui/features/lock_screen/remember_password/remember_password.dart';
import 'package:account_manager/ui/features/lock_screen/remember_password/remember_password_cubit.dart';
import 'package:account_manager/ui/features/notes/add_new_note/add_new_note_screen.dart';
import 'package:account_manager/ui/features/notes/notes_cubit.dart';
import 'package:account_manager/ui/features/notes/notes_screen.dart';
import 'package:account_manager/ui/screens/dashboard/dashboard_screen.dart';
import 'package:account_manager/ui/screens/dashboard/dashboard_screen1.dart';
import 'package:account_manager/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/income_expense/category_model.dart';
import '../ui/features/business_report/business_report_cubit.dart';
import '../ui/features/cash_counter/edit_cash_transaction/edit_cash_transaction.dart';
import '../ui/features/cash_counter/edit_cash_transaction/edit_cash_transaction_cubit.dart';
import '../ui/features/income_expense/category/add_category/add_category_screen.dart';
import '../ui/features/income_expense/edit_income_expense/edit_income_expense_cubit.dart';
import '../ui/features/notes/add_new_note/add_new_note_cubit.dart';
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
const String notes = '/notes';
const String backupNRestore = '/backupNRestore';
const String addNewNote = '/addNewNote';
const String businessReport = '/businessReport';
const String createPin = '/createPin';
const String pinAuthentication = '/pinAuthentication';
const String forgotPassword = '/forgotPassword';
const String rememberPassword = '/rememberPassword';

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
    case addNewNote:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => AddNewNoteCubit(
                    RepositoryProvider.of<NoteRepository>(context)),
                child: AddNewNoteScreen(
                  note: args as NoteModel?,
                ),
              ),
          settings: settings);
    case notes:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) =>
                    NotesCubit(RepositoryProvider.of<NoteRepository>(context)),
                child: NotesScreen(),
              ),
          settings: settings);
    case backupNRestore:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => BackupRestoreCubit(),
                child: BackupNRestoreScreen(),
              ),
          settings: settings);

    case businessReport:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => BusinessReportCubit(
                    RepositoryProvider.of<CreditDebitRepository>(context)),
                child: BusinessReportScreen(),
              ),
          settings: settings);

    case createPin:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => CreatePinCubit(),
                child: CreatePin(firstTime: args as bool,),
              ),
          settings: settings);
    case pinAuthentication:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => PinAuthenticationCubit(),
                child: const PinAuthenticationScreen(),
              ),
          settings: settings);
    case forgotPassword:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => ForgotPasswordCubit(),
                child: const ForgotPassword(),
              ),
          settings: settings);
    case rememberPassword:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => RememberPasswordCubit(),
                child: const RememberPassword(),
              ),
          settings: settings);

    default:
      throw ('this route name does not exist');
  }
}
