import 'package:account_manager/ui/features/income_expense/widgets/income_expense_summary.dart';
import 'package:flutter/material.dart';

import '../../../../utils/income_type.dart';
import '../add_income_expense/add_income_expense.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({Key? key}) : super(key: key);

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IncomeExpenseSummary(),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(onPressed: (){
              Navigator.pushNamed(context, "/addIncomeExpense",arguments:AddIncomeExpenseArgs(IncomeType.expense));
            }, label:  const Text("Expense"),
            icon: const Icon(Icons.add),
            ),
            const SizedBox(width: 16,),
            OutlinedButton.icon(onPressed: (){
              Navigator.pushNamed(context, "/addIncomeExpense",arguments:AddIncomeExpenseArgs(IncomeType.income));
            }, label: const Text("Income"),
              icon: const Icon(Icons.add),
            )
          ],
        )
      ],
    );
  }
}
