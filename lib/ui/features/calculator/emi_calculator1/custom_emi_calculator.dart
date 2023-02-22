import 'dart:math';

import 'package:account_manager/utils/date_time_helper.dart';
import 'package:account_manager/widgets/container_light.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/date_picker_widget.dart';
import '../../../../widgets/outlined_container.dart';
import '../../../../widgets/outlined_text_field.dart';

class CustomEMICalculator extends StatefulWidget {
  const CustomEMICalculator({Key? key}) : super(key: key);

  @override
  State<CustomEMICalculator> createState() => _CustomEMICalculatorState();
}

class _CustomEMICalculatorState extends State<CustomEMICalculator> {
  final TextEditingController _paymentDate = TextEditingController();
  final TextEditingController _returnDate = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String durationInWords = "0 Days";
  int _duration = 0;
  num emiPayable = 0;
  num totalInterestPayable = 0;
  num totalPayment = 0;

  void _calculate() {
    int diff = _endDate.millisecondsSinceEpoch-_startDate.millisecondsSinceEpoch;
    Duration mDuration = Duration(milliseconds: diff);
    _duration = mDuration.inDays;
    int noOfMonths = _duration~/30;
    int extraDays = _duration%30;
    int p = int.parse(_amount.text);
    num r = double.parse(_rate.text);
    int n = noOfMonths;

    /*
    r = ((r / 12) / 100);
    num first = pow(r + 1, n);
    num thirdP = first / (first - 1);
    num emi = p * r * thirdP;
    num emiPerDay = emi/30;
    emi +=emiPerDay*extraDays;
    */
    // customized calculation

    num emi = (r/100)*p;
    num emiPerDay = emi/30;

    num emi2 = emiPerDay*extraDays;
    // emi +=emiPerDay*extraDays;

    setState(() {
      durationInWords = DateTimeHelper.prettyDuration(diff);
      emiPayable = emi;
      totalInterestPayable =(emi * n)+emi2;
      totalPayment =  p + totalInterestPayable;

    });
  }

  calculateDuration(){
    int diff = _endDate.millisecondsSinceEpoch-_startDate.millisecondsSinceEpoch;
    setState((){
      durationInWords = DateTimeHelper.prettyDuration(diff);
    });
  }
  Widget label(String text) {
    return Text(text, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Row(
            children: [
              Expanded(flex: 3, child: label("Start Date")),
              Expanded(
                flex: 7,
                child: DatePickerWidget(onDateSelected: (dateTime) {
                  _startDate = dateTime;
                  calculateDuration();
                }),

              )
            ],
          ),
          Row(
            children: [
               Expanded(flex: 3, child: label("End Date")),
              Expanded(
                flex: 7,
                child: DatePickerWidget(onDateSelected: (dateTime) {
                  _endDate = dateTime;
                  calculateDuration();
                }),
              )
            ],
          ),
          ContainerLight(

            childWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  label("Duration : "),
                  const SizedBox(width: 16,),
                  label(durationInWords)
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(
            vertical: 12,
          ),child: Divider(thickness: 2,),),
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
            maxLength: 5,
            hintText: "Rate",
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
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text("EMI Payable"),
                          Text("₹$emiPayable",style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600),),

                        ],
                      ),
                      Column(
                        children: [
                          const Text("Total Interest Payable"),
                          Text("₹$totalInterestPayable",style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600)),

                        ],
                      )
                    ],
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      label("Total Interest Payable"),
                      Text(":  ₹${totalInterestPayable.toStringAsFixed(0)}",style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600)),

                    ],
                  ),

                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      )),
    );
  }
}
