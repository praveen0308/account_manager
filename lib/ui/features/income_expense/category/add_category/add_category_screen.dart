import 'package:account_manager/models/income_expense/category_model.dart';
import 'package:account_manager/ui/features/income_expense/category/add_category/add_category_cubit.dart';
import 'package:account_manager/utils/income_type.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../../../../../widgets/outlined_text_field.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  IncomeType? _type = IncomeType.income;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  int pickedIcon = 0;
  Icon _icon = const Icon(Icons.edit);

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _icon = Icon(
      icon,
      size: 32,
    );
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Add Category")),
      body: BlocConsumer<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {
          if (state is AddedSuccessfully) {
            showToast("Added Successfully!!!", ToastType.success);
            Navigator.pop(context);
          }
          if (state is Failed) {
            showToast("Unable to add category!!", ToastType.error);
          }
        },
        builder: (context, state) {
          return Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<IncomeType>(
                            title: const Text('Income'),
                            value: IncomeType.income,
                            groupValue: _type,
                            onChanged: (IncomeType? value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<IncomeType>(
                            title: const Text('Expense'),
                            value: IncomeType.expense,
                            groupValue: _type,
                            onChanged: (IncomeType? value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    label("Name"),
                    OutlinedTextField(
                      controller: _name,
                      inputType: TextInputType.text,
                      maxLength: 30,
                      hintText: "Category Name",
                      onTextChanged: (String txt) {},
                      onSubmitted: (String txt) {},
                    ),
                    Row(
                      children: [
                        _icon,
                        const SizedBox(
                          width: 16,
                        ),
                        OutlinedButton(
                            onPressed: _pickIcon,
                            child: const Text("Pick an icon"))
                      ],
                    ),
                    label("Description"),
                    OutlinedTextField(
                      controller: _description,
                      inputType: TextInputType.text,
                      maxLength: 100,
                      hintText: "Enter description",
                      onTextChanged: (String txt) {},
                      onSubmitted: (String txt) {},
                    ),
                    const Spacer(),
                    if (state is Loading) const CircularProgressIndicator(),
                    if (state is! Loading)
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AddCategoryCubit>(context)
                                .addNewCategory(CategoryModel(
                                    icon: _icon.icon!.codePoint,
                                    name: _name.text,
                                    type: _type!.name,
                                    description: _description.text));
                          },
                          child: const Text("Submit"))
                  ]),
            ),
          );
        },
      ),
    ));
  }
}
