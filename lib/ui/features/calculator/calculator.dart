import 'package:account_manager/ui/features/calculator/emi_calculator/emi_calculator.dart';
import 'package:account_manager/ui/features/calculator/emi_calculator1/custom_emi_calculator.dart';
import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_strings.dart';

class MainCalculator extends StatefulWidget {
  const MainCalculator({Key? key}) : super(key: key);

  @override
  State<MainCalculator> createState() => _MainCalculatorState();
}

class _MainCalculatorState extends State<MainCalculator> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(AppStrings.emiCalculator),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: const [
            TabBar(

              indicatorWeight: 3,
              labelColor: AppColors.primaryDarkest,
              indicatorColor: AppColors.primaryDarkest,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [

                Tab(
                  text: "Standard",
                ),
                Tab(
                  text: "Custom",
                ),

              ],
            ),

            SizedBox(height: 8,),
            Expanded(
              child: TabBarView(
                children: [
                 EmiCalculator(),
                  CustomEMICalculator(),

                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
