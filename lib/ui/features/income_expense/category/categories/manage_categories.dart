import 'package:account_manager/ui/features/income_expense/category/categories/manage_categories_cubit.dart';
import 'package:account_manager/utils/income_type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../../../../../res/app_colors.dart';

class ManageCategories extends StatefulWidget {
  const ManageCategories({Key? key}) : super(key: key);

  @override
  State<ManageCategories> createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  IncomeType activeType = IncomeType.income;
  @override
  void initState() {
    BlocProvider.of<ManageCategoriesCubit>(context)
        .fetchCategories(activeType);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IncomeExpenseGroup(onChanged: (type) {
            activeType = type;
            BlocProvider.of<ManageCategoriesCubit>(context)
                .fetchCategories(activeType);
          }),
          Expanded(
            child: BlocBuilder<ManageCategoriesCubit, ManageCategoriesState>(
                builder: (context, state) {
              if (state is ReceivedCategories) {
                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    var category = state.categories[index];

                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "/categoryDetail",arguments: category).then((value) => BlocProvider.of<ManageCategoriesCubit>(context)
                            .fetchCategories(activeType));

                      },
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                          IconData(category.icon, fontFamily: "MaterialIcons")),
                      title: Text(category.name),
                      trailing: const Icon(Icons.chevron_right),
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
                return const CircularProgressIndicator();
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.category_outlined,
                      size: 80,
                    ),
                    Text("No Categories!!")
                  ],
                ),
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryDarkest,
          onPressed: () {
            Navigator.pushNamed(context, "/addCategory");
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }


}

class IncomeExpenseGroup extends StatefulWidget {
  final Function(IncomeType type) onChanged;

  const IncomeExpenseGroup({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<IncomeExpenseGroup> createState() => _IncomeExpenseGroupState();
}

class _IncomeExpenseGroupState extends State<IncomeExpenseGroup> {
  IncomeType _incomeType = IncomeType.income;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            widget.onChanged(IncomeType.income);
            setState(() {
              _incomeType = IncomeType.income;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            decoration: BoxDecoration(
                color: _incomeType == IncomeType.income
                    ? AppColors.primaryDarkest
                    : AppColors.white,
                border: Border.all(color: AppColors.primaryDarkest),
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              "Income",
              style: TextStyle(
                  color: _incomeType == IncomeType.income
                      ? AppColors.white
                      : AppColors.primaryDarkest),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: () {
            widget.onChanged(IncomeType.expense);
            setState(() {
              _incomeType = IncomeType.expense;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            decoration: BoxDecoration(
                color: _incomeType == IncomeType.expense
                    ? AppColors.primaryDarkest
                    : AppColors.white,
                border: Border.all(color: AppColors.primaryDarkest),
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              "Expense",
              style: TextStyle(
                  color: _incomeType == IncomeType.expense
                      ? AppColors.white
                      : AppColors.primaryDarkest),
            ),
          ),
        )
      ],
    );
  }
}
