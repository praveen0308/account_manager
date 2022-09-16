import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:flutter/material.dart';

class CashCounterScreen extends StatefulWidget {
  const CashCounterScreen({Key? key}) : super(key: key);

  @override
  State<CashCounterScreen> createState() => _CashCounterScreenState();
}

class _CashCounterScreenState extends State<CashCounterScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.cashCounter),
      ),
      body: Column(
        children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryLightest,
                borderRadius: BorderRadius.circular(8)
              ),
            )),

        ],
      ),
    ));
  }
}
