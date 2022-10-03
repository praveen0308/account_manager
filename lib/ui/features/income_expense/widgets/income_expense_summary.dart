import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/widgets/container_light.dart';
import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IncomeExpenseSummary extends StatefulWidget {
  const IncomeExpenseSummary({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseSummary> createState() => _IncomeExpenseSummaryState();
}

class _IncomeExpenseSummaryState extends State<IncomeExpenseSummary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          OutlinedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(icon:const Icon(Icons.chevron_left_rounded,size: 28), onPressed: () {  },),

                  const Expanded(child: Text("September",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.primaryDarkest),),),

                  IconButton(icon:const Icon(Icons.chevron_right_rounded,size: 28), onPressed: () {  },),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: LinearPercentIndicator(
                  lineHeight: 20.0,
                  percent: 0.5,
                  barRadius: const Radius.circular(10),
                  progressColor: AppColors.successDark,
                  backgroundColor: AppColors.error,
                ),
              ),
              buildContentRow("Income", 15000,prefix: "+",color: AppColors.successDark),
              buildContentRow("Expense", 5000,prefix: "+",color: AppColors.error),
              const Divider(thickness: 2,),
              buildContentRow("Balance", 10000),

            ],
          )),
        ],
      ),
    );
  }

  Widget buildContentRow(String title,double value,{String prefix="",Color color=AppColors.primaryText}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
          Text("$prefix₹$value",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: color))
        ],
      ),
    );
  }
}
