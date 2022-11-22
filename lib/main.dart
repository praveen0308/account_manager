import 'package:account_manager/repository/cash_transaction_repository.dart';
import 'package:account_manager/repository/category_repository.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/repository/currency_repository.dart';
import 'package:account_manager/repository/income_expense_repository.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:account_manager/route/route.dart' as route;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CashTransactionRepository()),
        RepositoryProvider(create: (_) => CashTransactionRepository()),
        RepositoryProvider(create: (_) => CreditDebitRepository()),
        RepositoryProvider(create: (_) => CurrencyRepository()),
        RepositoryProvider(create: (_) => CategoryRepository()),
        RepositoryProvider(create: (_) => IncomeExpenseRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Account Manager',
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
              buttonColor: AppColors.primaryDarkest,
              textTheme: ButtonTextTheme.accent,
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(secondary: Colors.white)),
          iconTheme: const IconThemeData(color: AppColors.primaryDarkest),
          primarySwatch: AppColors.primarySwatchColor,
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent,
          ),
          textTheme: TextTheme(),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                  color: AppColors.primaryDarkest,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              iconTheme:
                  IconThemeData(color: AppColors.primaryDarkest, size: 32)),
        ).copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryDarkest,
                    onPrimary: AppColors.white))),
        initialRoute: route.splashScreen,
        onGenerateRoute: route.controller,
      ),
    );
  }
}
