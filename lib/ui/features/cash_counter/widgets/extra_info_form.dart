import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/app_colors.dart';
import '../../../../widgets/outlined_text_field.dart';

class ExtraInfoForm extends StatefulWidget {
  const ExtraInfoForm({Key? key}) : super(key: key);

  @override
  State<ExtraInfoForm> createState() => _ExtraInfoFormState();
}

class _ExtraInfoFormState extends State<ExtraInfoForm> {

  bool _addIntoCreditDebit = false;
  final TextEditingController _manuallyAddedController = TextEditingController();
  final TextEditingController _manuallySubtractedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Denomination Total",
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            BlocBuilder<CashCounterCubit, CashCounterState>(
              builder: (context, state) {
                return Text(
                  state.denominationTotal.toString(),
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                );
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Manually Added(+)",
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            SizedBox(
              width: 100,
              child: OutlinedTextField(
                controller: _manuallyAddedController,
                inputType: TextInputType.number,
                maxLength: 7,
                onSubmitted: (String txt) {
                  BlocProvider.of<CashCounterCubit>(context).updateManuallyAddedAmt(txt);
                },
                onTextChanged: (String txt) {
                  BlocProvider.of<CashCounterCubit>(context).updateManuallyAddedAmt(txt);
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Manually Subtracted(-)",
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            SizedBox(
              width: 100,
              child: OutlinedTextField(
                controller: _manuallySubtractedController,
                inputType: TextInputType.number,
                maxLength: 7,
                onSubmitted: (String txt) {
                  BlocProvider.of<CashCounterCubit>(context).updateManuallySubtractedAmt(txt);
                },
                onTextChanged: (String txt) {
                  BlocProvider.of<CashCounterCubit>(context).updateManuallySubtractedAmt(txt);
                },
              ),
            ),
          ],
        ),
        OutlinedTextField(
          controller: TextEditingController(),
          inputType: TextInputType.text,
          maxLength: 50,
          onSubmitted: (String txt) {
            BlocProvider.of<CashCounterCubit>(context).personName = txt;
          },
          onTextChanged: (String txt) {
            BlocProvider.of<CashCounterCubit>(context).personName = txt;
          },
          hintText: "Person Name",
        ),

        OutlinedTextField(
          controller: TextEditingController(),
          inputType: TextInputType.text,
          maxLength: 200,
          onSubmitted: (String txt) {
            BlocProvider.of<CashCounterCubit>(context).remark = txt;
          },
          onTextChanged: (String txt) {
            BlocProvider.of<CashCounterCubit>(context).remark = txt;
          },
          hintText: "Remark",
        ),
        CheckboxListTile(
          activeColor: AppColors.primaryDarkest,
          value: _addIntoCreditDebit,
          onChanged: (v) {
            setState(() {
              _addIntoCreditDebit = v!;
            });
          },
          title: const Text(
            "Add into Credit Debit",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),
          ),
        )
      ],
    );
  }
}
