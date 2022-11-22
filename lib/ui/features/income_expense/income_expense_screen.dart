import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/ui/features/income_expense/category/categories/manage_categories.dart';
import 'package:account_manager/ui/features/income_expense/category/categories/manage_categories_cubit.dart';
import 'package:account_manager/ui/features/income_expense/spending/spending_screen.dart';
import 'package:account_manager/ui/features/income_expense/spending/spending_screen_cubit.dart';
import 'package:account_manager/ui/features/income_expense/transactions/transactions_screen.dart';
import 'package:account_manager/ui/features/income_expense/transactions/transactions_screen_cubit.dart';
import 'package:account_manager/ui/features/income_expense/widgets/income_expense_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/category_repository.dart';
import '../../../repository/income_expense_repository.dart';
import '../../../res/app_colors.dart';

class IncomeExpenseScreen extends StatefulWidget {
  const IncomeExpenseScreen({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseScreen> createState() => _IncomeExpenseScreenState();
}

class _IncomeExpenseScreenState extends State<IncomeExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.incomeExpense),
            actions: [ TextButton(onPressed: () {}, child: Text("This Month"))],
          ),
          body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(

                  indicatorWeight: 3,
                  labelColor: AppColors.primaryDarkest,
                  indicatorColor: AppColors.primaryDarkest,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [

                    Tab(
                      icon: Icon(Icons.incomplete_circle_rounded),
                      text: "Spending",
                    ),
                    Tab(
                      icon: Icon(Icons.list_alt_rounded),
                      text: "Transactions",
                    ),
                    Tab(
                      icon: Icon(Icons.category_rounded),
                      text: "Categories",
                    ),

                  ],
                ),

                const SizedBox(height: 8,),
                Expanded(
                  child: TabBarView(
                    children: [

                      BlocProvider(
                        create: (context) =>
                            SpendingScreenCubit(
                                RepositoryProvider.of<IncomeExpenseRepository>(
                                    context)
                            ),
                        child: const SpendingScreen(),
                      ),
                      BlocProvider(
                        create: (context) => TransactionsScreenCubit(
                          RepositoryProvider.of<IncomeExpenseRepository>(context)
                        ),
                        child: TransactionsScreen(),
                      ),
                      BlocProvider(
                        create: (context) =>
                            ManageCategoriesCubit(
                                RepositoryProvider.of<CategoryRepository>(
                                    context)),
                        child: const ManageCategories(),
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
