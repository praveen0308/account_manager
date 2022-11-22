import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/income_expense/transactions/transactions_screen_cubit.dart';
import 'package:account_manager/utils/income_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionsScreenCubit, TransactionsScreenState>(
        builder: (context, state) {
          if (state is ReceivedTransactions) {
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                var transaction = state.transactions[index];

                return ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Icon(
                      IconData(transaction.icon!, fontFamily: "MaterialIcons")),
                  title: Text(transaction.remark ?? transaction.categoryName!),
                  subtitle: Text(transaction.getDate()),
                  trailing: Text(
                    "₹${transaction.getAmount()}",
                    style: TextStyle(
                        color: transaction.type == IncomeType.income.toString()
                            ? AppColors.successDark
                            : AppColors.error,
                        fontSize: 20,fontWeight: FontWeight.w700),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                );
              },
            );
          }
          if (state is Loading) {
            return Center(child: const CircularProgressIndicator());
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.category_outlined,
                  size: 80,
                ),
                Text("No income or expense this month!!")
              ],
            ),
          );
        },
        listener: (context, state) {});
  }

  @override
  void initState() {
    BlocProvider.of<TransactionsScreenCubit>(context).fetchTransactions();
  }
}
