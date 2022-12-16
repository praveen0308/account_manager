import 'package:account_manager/ui/features/income_expense/category/category_detail/category_detail_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../../../../../models/income_expense/category_model.dart';
import '../../../../../utils/income_type.dart';
import '../../../../../widgets/outlined_text_field.dart';

class CategoryDetailScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryDetailScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  IncomeType? _type = IncomeType.income;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  int pickedIcon = 0;
  Icon _icon = const Icon(Icons.edit);

  @override
  void initState() {
    if(widget.category.type=="expense"){
      _type = IncomeType.expense;
    }
    _name.text = widget.category.name;
    _description.text = widget.category.description;
    pickedIcon = widget.category.icon;
    _icon = Icon(IconData(pickedIcon, fontFamily: "MaterialIcons"));
    super.initState();
  }

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
      appBar: AppBar(title: const Text("Edit Category")),
      body: BlocConsumer<CategoryDetailCubit, CategoryDetailState>(
        listener: (context, state) {
          if (state is UpdatedSuccessfully) {
            showToast("Updated Successfully!!!", ToastType.success);
            Navigator.pop(context,true);
          }
          if (state is DeletedSuccessfully) {
            showToast("Deleted Successfully!!!", ToastType.success);
            Navigator.pop(context,true);
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
                    if (state is Deleting) const Center(child: CircularProgressIndicator()),
                    if (state is! Deleting)
                    SecondaryButton(onClick: () {
                      BlocProvider.of<CategoryDetailCubit>(context).deleteCategory(widget.category.categoryId!);
                    }, text: "Delete"),
                    const SizedBox(height: 16,),
                    if (state is Updating) const Center(child: CircularProgressIndicator()),
                    if (state is! Updating)
                    PrimaryButton(
                        onClick: () {
                          BlocProvider.of<CategoryDetailCubit>(context)
                              .updateCategory(CategoryModel(
                                  categoryId: widget.category.categoryId,
                                  icon: _icon.icon!.codePoint,
                                  name: _name.text,
                                  type: _type!.name,
                                  description: _description.text));
                        },
                        text: "Update"),


                  ]),
            ),
          );
        },
      ),
    ));
  }
}
