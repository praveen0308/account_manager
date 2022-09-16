import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class EmiCalculator extends StatefulWidget {
  const EmiCalculator({Key? key}) : super(key: key);

  @override
  State<EmiCalculator> createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.emiCalculator),
      ),
      body: Container(),
    ));
  }
}
