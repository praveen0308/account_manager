import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/income_expense/income_expense_parent_cubit.dart';
import 'package:account_manager/widgets/container_light.dart';
import 'package:account_manager/widgets/date_filter_bar.dart';
import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../utils/date_time_helper.dart';

class IncomeExpenseSummary extends StatefulWidget {
  const IncomeExpenseSummary({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseSummary> createState() => _IncomeExpenseSummaryState();
}

class _IncomeExpenseSummaryState extends State<IncomeExpenseSummary> {
  DateTime _fDate = DateTime.now();
  var activeFilter = DateFilter.monthly;

  @override
  void initState() {
    BlocProvider.of<IncomeExpenseParentCubit>(context)
        .fetchTransactions(_fDate, activeFilter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OutlinedContainer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DateFilterBar(filterChanged: (date, filter) {
            _fDate = date;
            activeFilter = filter;
            BlocProvider.of<IncomeExpenseParentCubit>(context)
                .fetchTransactions(date, filter);
          }),
          BlocBuilder<IncomeExpenseParentCubit, IncomeExpenseParentState>(
            builder: (context, state) {
              if (state is ReceivedSummary) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: LinearPercentIndicator(
                        lineHeight: 20.0,
                        percent: (state.expense / state.income),
                        barRadius: const Radius.circular(10),
                        progressColor: AppColors.error,
                        backgroundColor: AppColors.successDark,
                      ),
                    ),
                    buildContentRow("Income", state.income,
                        prefix: "+", color: AppColors.successDark),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.incomeCats.length,
                        itemBuilder: (context, index) {
                          String key = state.incomeCats.keys.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(key.toString(),style: const TextStyle(fontWeight: FontWeight.w500),),
                                Text("+₹${state.incomeCats[key]}",style: const TextStyle(fontWeight: FontWeight.w500,color: AppColors.success),),
                              ],
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 0.75,
                    ),
                    buildContentRow("Expense", state.expense,
                        prefix: "-", color: AppColors.error),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.expenseCats.length,
                        itemBuilder: (context, index) {
                          String key = state.expenseCats.keys.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(key.toString(),style: const TextStyle(fontWeight: FontWeight.w500),),
                                Text("-₹${state.expenseCats[key]}",style: const TextStyle(fontWeight: FontWeight.w500,color: AppColors.error),),
                              ],
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 2,
                    ),
                    buildContentRow("Balance", state.income - state.expense),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      )),
    );
  }

  Widget buildContentRow(String title, num value,
      {String prefix = "", Color color = AppColors.primaryText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text("$prefix₹$value",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16, color: color))
        ],
      ),
    );
  }
}
