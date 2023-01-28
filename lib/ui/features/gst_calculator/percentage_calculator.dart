import 'package:account_manager/widgets/outlined_text_field.dart';
import 'package:flutter/material.dart';

class PercentageCalculator extends StatefulWidget {
  const PercentageCalculator({Key? key}) : super(key: key);

  @override
  State<PercentageCalculator> createState() => _PercentageCalculatorState();
}

class _PercentageCalculatorState extends State<PercentageCalculator> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _percentage = TextEditingController();

  String result = "0";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      height: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          const Text("Calculate Percentage",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
          const SizedBox(height: 16,),
          OutlinedTextField(
              controller: _amount,
              onTextChanged: (txt) {},
              onSubmitted: (txt) {},
              inputType: TextInputType.number,
              maxLength: 15,
              hintText: "Enter amount"),

          OutlinedTextField(
              controller: _percentage,
              onTextChanged: (txt) {},
              onSubmitted: (txt) {},
              inputType: TextInputType.number,
              maxLength: 6,
              hintText: "Enter percentage"),

          const SizedBox(height: 8,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Text("= $result",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),

            ElevatedButton(onPressed: (){
              double p = double.parse(_percentage.text);
              double a = double.parse(_amount.text)/100;
              num per = p*a;
              result = per.toStringAsFixed(2);
              setState((){});
            }, child: const Text("Calculate")),

          ],),



        ],
      ),
    );
  }
}
