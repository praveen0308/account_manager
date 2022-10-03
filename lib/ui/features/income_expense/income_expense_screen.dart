import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/ui/features/income_expense/widgets/income_expense_summary.dart';
import 'package:flutter/material.dart';

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
      ),
      body: Container(
        child: Column(
          children: [IncomeExpenseSummary()],
        ),
      ),
    ));
  }
}
