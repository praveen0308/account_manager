import 'dart:math';

import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/outlined_text_field.dart';
import '../../../../widgets/primary_button.dart';

class EmiCalculator extends StatefulWidget {
  const EmiCalculator({Key? key}) : super(key: key);

  @override
  State<EmiCalculator> createState() => _EmiCalculatorState();
}

enum DurationFormat { yearly, monthly }

class _EmiCalculatorState extends State<EmiCalculator> {
  DurationFormat? _format = DurationFormat.yearly;
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  final TextEditingController _rate = TextEditingController();

  num emiPayable = 0;
  num totalInterestPayable = 0;
  num totalPayment = 0;

  void _calculate() {
    int p = int.parse(_amount.text);
    num r = double.parse(_rate.text);
    int n = int.parse(_duration.text);
    if (_format == DurationFormat.yearly) n = n * 12;
    r = ((r / 12) / 100);
    num first = pow(r + 1, n);

    num thirdP = first / (first - 1);
    num emi = p * r * thirdP;
    setState(() {

      emiPayable = emi;
      totalPayment = (emi * n);
      totalInterestPayable = totalPayment - p;
    });
  }

  Widget label(String text) {
    return Text(text, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            label("Loan Amount"),
            OutlinedTextField(
              controller: _amount,
              inputType: TextInputType.number,
              maxLength: 10,
              hintText: "Amount",
              onTextChanged: (String txt) {},
              onSubmitted: (String txt) {},
            ),
            label("Interest Rate(%)"),
            OutlinedTextField(
              controller: _rate,
              inputType: TextInputType.number,
              maxLength: 3,
              hintText: "Rate",
              onTextChanged: (String txt) {},
              onSubmitted: (String txt) {},
            ),

            Row(
              children: [
                Expanded(
                  child: RadioListTile<DurationFormat>(
                    title: const Text('Yearly'),
                    value: DurationFormat.yearly,
                    groupValue: _format,
                    onChanged: (DurationFormat? value) {
                      setState(() {
                        _format = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<DurationFormat>(
                    title: const Text('Monthly'),
                    value: DurationFormat.monthly,
                    groupValue: _format,
                    onChanged: (DurationFormat? value) {
                      setState(() {
                        _format = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            label("Loan Term"),
            OutlinedTextField(
              controller: _duration,
              inputType: TextInputType.number,
              maxLength: 3,
              hintText: "Duration",
              onTextChanged: (String txt) {},
              onSubmitted: (String txt) {},
            ),

            const Text(
              "Result : ",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("EMI Payable"),
                            Text("₹${emiPayable.toStringAsFixed(0)}",style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600),),

                          ],
                        ),
                        Column(
                          children: [
                            const Text("Total Interest Payable"),
                            Text("₹${totalInterestPayable.toStringAsFixed(0)}",style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600)),

                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        label("Total Payment\n(Principal + Interest) "),
                        Text(": ₹${totalPayment.toStringAsFixed(0)}",style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600))
                      ],
                    ),
                  ],
                )),
            const Spacer(),
            PrimaryButton(
              onClick: _calculate,
              text: 'Calculate',

            )
          ],
        ),
      ),
    );
  }
}
