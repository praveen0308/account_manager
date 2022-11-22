import 'package:account_manager/models/income_expense/category_model.dart';
import 'package:account_manager/models/income_expense/income_expense_model.dart';
import 'package:account_manager/ui/features/income_expense/add_income_expense/add_income_expense_cubit.dart';
import 'package:account_manager/utils/income_type.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/date_picker_widget.dart';
import 'package:account_manager/widgets/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/app_colors.dart';

class AddIncomeExpenseArgs {
  final IncomeType type;

  AddIncomeExpenseArgs(this.type);
}

class AddIncomeExpense extends StatefulWidget {
  final AddIncomeExpenseArgs args;

  const AddIncomeExpense({Key? key, required this.args}) : super(key: key);

  @override
  State<AddIncomeExpense> createState() => _AddIncomeExpenseState();
}

class _AddIncomeExpenseState extends State<AddIncomeExpense> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _remark = TextEditingController();
  CategoryModel? selectedCategory;
  final DateTime transactionDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AddIncomeExpenseCubit, AddIncomeExpenseState>(
          listener: (context, state) {
            if(state is AddedSuccessfully){
              showToast("Added Successfully !!!",ToastType.success);
              Navigator.pop(context);
            }
            if(state is Failed){
              showToast("Failed to add transaction !!!",ToastType.error);
            }
            if(state is Error){
              showToast(state.msg,ToastType.error);
            }


          },
          builder: (context, state) {
            return Form(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedTextField(
                    controller: _amount,
                    onTextChanged: (txt) {},
                    onSubmitted: (txt) {},
                    inputType: TextInputType.number,
                    maxLength: 10,
                    label: const Text("Amount"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Expanded(flex: 3, child: Text("Category")),
                      if (selectedCategory != null)
                        Expanded(
                          flex: 7,
                          child: ListTile(
                            shape: Border.all(color: AppColors.primaryDarkest),
                            onTap: () async {
                              var result = await Navigator.pushNamed(
                                  context, "/pickCategory",
                                  arguments: widget.args.type);
                              setState(() {
                                selectedCategory = result as CategoryModel;
                              });
                            },
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            leading: Icon(IconData(selectedCategory!.icon,
                                fontFamily: "MaterialIcons")),
                            title: Text(selectedCategory!.name),
                          ),
                        ),
                      if (selectedCategory == null)
                        Expanded(
                          flex: 7,
                          child: OutlinedButton(
                              onPressed: () async {
                                var result = await Navigator.pushNamed(
                                    context, "/pickCategory",
                                    arguments: widget.args.type);
                                setState(() {
                                  selectedCategory = result as CategoryModel;
                                });
                              },
                              child: const Text("Choose Category")),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Expanded(flex: 3, child: Text("Date")),
                      Expanded(
                        flex: 7,
                        child: DatePickerWidget(onDateSelected: (dateTime) {}),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  OutlinedTextField(
                    controller: _remark,
                    onTextChanged: (txt) {},
                    onSubmitted: (txt) {},
                    inputType: TextInputType.text,
                    maxLength: 100,
                    label: const Text("Remark"),
                  ),
                  const Spacer(),
                  if (state is Loading) const CircularProgressIndicator(),
                  if (state is! Loading)
                    ElevatedButton(
                        onPressed: () {
                          double amount = double.parse(_amount.text);

                          BlocProvider.of<AddIncomeExpenseCubit>(context)
                              .addIncomeExpense(IncomeExpenseModel(
                                  categoryId: selectedCategory!.categoryId!,
                                  type: widget.args.type.toString(),
                                  remark: _remark.text,
                                  amount: amount,
                                  date: transactionDate.millisecondsSinceEpoch,
                                  addedOn: DateTime.now().millisecondsSinceEpoch
                                  ));
                        },
                        child: const Text("Submit"))
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
