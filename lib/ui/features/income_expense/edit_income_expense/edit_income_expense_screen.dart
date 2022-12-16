import 'package:account_manager/ui/features/income_expense/edit_income_expense/edit_income_expense_cubit.dart';
import 'package:account_manager/utils/income_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/income_expense/category_model.dart';
import '../../../../models/income_expense/income_expense_model.dart';
import '../../../../res/app_colors.dart';
import '../../../../utils/toaster.dart';
import '../../../../widgets/date_picker_widget.dart';
import '../../../../widgets/outlined_text_field.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/secondary_button.dart';

class EditIncomeExpenseScreen extends StatefulWidget {
  final IncomeExpenseModel transaction;

  const EditIncomeExpenseScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<EditIncomeExpenseScreen> createState() =>
      _EditIncomeExpenseScreenState();
}

class _EditIncomeExpenseScreenState extends State<EditIncomeExpenseScreen> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _remark = TextEditingController();
  CategoryModel? selectedCategory;
  DateTime transactionDate = DateTime.now();
  IncomeType type = IncomeType.income;

  @override
  void initState() {
    selectedCategory = CategoryModel(
        categoryId: widget.transaction.categoryId,
        icon: widget.transaction.icon??Icons.warning_rounded.codePoint,
        type: widget.transaction.type,
        name: widget.transaction.categoryName??"Other");
    transactionDate =
        DateTime.fromMillisecondsSinceEpoch(widget.transaction.date);
    _amount.text = widget.transaction.amount.toString();
    _remark.text = widget.transaction.remark.toString();
    if(widget.transaction.type=="expense"){
      type = IncomeType.expense;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<EditIncomeExpenseCubit, EditIncomeExpenseState>(
          listener: (context, state) {
            if (state is UpdatedSuccessfully) {
              showToast("Updated Successfully !!!", ToastType.success);
              Navigator.pop(context, true);
            }

            if (state is DeletedSuccessfully) {
              showToast("Deleted Successfully !!!", ToastType.success);
              Navigator.pop(context, true);
            }

            if (state is Error) {
              showToast(state.msg, ToastType.error);
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
                                  arguments: type);
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
                                    arguments: type);
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
                        child: DatePickerWidget(onDateSelected: (dateTime) {
                          transactionDate = dateTime;
                        }),
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
                  if (state is Deleting)
                    const Center(child: CircularProgressIndicator()),
                  if (state is! Deleting)
                    SecondaryButton(
                        onClick: () {
                          BlocProvider.of<EditIncomeExpenseCubit>(context)
                              .deleteIncomeExpense(widget.transaction.transactionId!);
                        },
                        text: "Delete"),
                  const SizedBox(
                    height: 16,
                  ),
                  if (state is Updating)
                    const Center(child: CircularProgressIndicator()),
                  if (state is! Updating)
                    PrimaryButton(
                        onClick: () {
                          double amount = double.parse(_amount.text);

                          BlocProvider.of<EditIncomeExpenseCubit>(context)
                              .updateIncomeExpense(IncomeExpenseModel(
                                  transactionId:
                                      widget.transaction.transactionId,
                                  categoryId: selectedCategory!.categoryId!,
                                  type: widget.transaction.type,
                                  remark: _remark.text,
                                  amount: amount,
                                  date: transactionDate.millisecondsSinceEpoch,
                                  addedOn:
                                      DateTime.now().millisecondsSinceEpoch));
                        },
                        text: "Update"),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
