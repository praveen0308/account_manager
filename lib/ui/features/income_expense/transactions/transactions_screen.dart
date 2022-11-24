import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/income_expense/transactions/transactions_screen_cubit.dart';
import 'package:account_manager/utils/income_type.dart';
import 'package:account_manager/widgets/custom_dropdown.dart';
import 'package:account_manager/widgets/date_filter_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/date_time_helper.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  DateTime _fDate = DateTime.now();
  var activeFilter = DateFilter.monthly;
  final List<String> _typeFilters = ["All", "Income", "Expense"];
  final List<String> _otherFilters = ["Newest to Old", "Oldest to New", "Low to High","High to Low"];
  var typeFilter = "All";
  var otherFilter = "Newest to Old";

  @override
  void initState() {
    BlocProvider.of<TransactionsScreenCubit>(context)
        .fetchTransactions(_fDate, activeFilter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateFilterBar(filterChanged: (date, filter) {
          _fDate = date;
          activeFilter = filter;
          BlocProvider.of<TransactionsScreenCubit>(context)
              .fetchTransactions(_fDate, activeFilter);
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: _typeFilters
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ))
                      .toList(),
                  value: typeFilter,
                  onChanged: (value) {
                    setState(() {
                      typeFilter = value as String;
                      BlocProvider.of<TransactionsScreenCubit>(context).applyFilter(typeFilter, otherFilter);
                    });

                  },
                  buttonHeight: 40,
                  itemHeight: 40,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.primaryDarkest,
                      width: 1.5
                    ),
                    color: Colors.white,
                  ),

                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),


                  ),
                )),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: DropdownButtonHideUnderline(
                    child: FittedBox(
                      child: DropdownButton2(
                  hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                  ),
                  items: _otherFilters
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ))
                        .toList(),
                  value: otherFilter,
                  onChanged: (value) {
                      setState(() {
                        otherFilter = value as String;
                        BlocProvider.of<TransactionsScreenCubit>(context).applyFilter(typeFilter, otherFilter);
                      });

                  },
                  buttonHeight: 40,

                  itemHeight: 40,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.primaryDarkest,
                        width: 1.5
                      ),
                      color: Colors.white,
                  ),

                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),

                  ),
                ),
                    )),
              ),
            ],
          ),
        ),
        BlocConsumer<TransactionsScreenCubit, TransactionsScreenState>(
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
                      leading: Icon(IconData(transaction.icon!,
                          fontFamily: "MaterialIcons")),
                      title: Text(transaction.remark!.isNotEmpty
                          ? transaction.remark!
                          : transaction.categoryName!),
                      subtitle: Text(transaction.getDate()),
                      trailing: Text(
                        "₹${transaction.getAmount()}",
                        style: TextStyle(
                            color: transaction.type == IncomeType.income.name
                                ? AppColors.successDark
                                : AppColors.error,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 0.2,
                      color: Colors.black,
                    );
                  },
                );
              }
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
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
            listener: (context, state) {}),
        const Spacer(),
        BlocBuilder<TransactionsScreenCubit, TransactionsScreenState>(
          builder: (context, state) {
            return Row(
              children: [
                _buildTotalView(
                    BlocProvider.of<TransactionsScreenCubit>(context).expense,
                    IncomeType.expense),
                _buildTotalView(
                    BlocProvider.of<TransactionsScreenCubit>(context).income,
                    IncomeType.income),
              ],
            );
          },
        )
      ],
    );
  }

  Widget _buildTotalView(num amount, IncomeType type) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: type == IncomeType.income
          ? AppColors.successLightest
          : AppColors.errorLightest,
      child: Center(
        child: Text(
          "₹$amount",
          style: TextStyle(
              fontSize: 22,
              color: type == IncomeType.income
                  ? AppColors.successDark
                  : AppColors.error,
              fontWeight: FontWeight.w700),
        ),
      ),
    ));
  }

}

