import 'package:account_manager/ui/features/gst_calculator/widgets/button_model.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class BtnType1 extends StatelessWidget {
  final ButtonModel buttonModel;
  final Function() onItemClick;

  const BtnType1({Key? key, required this.buttonModel, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),

      ),
      onTap: onItemClick,
      splashColor: AppColors.primaryDarkest50
      ,
      child: Ink(

        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: buttonModel.action == CalcAction.allClear
              ? AppColors.primaryDarkest
              : AppColors.primaryLightest,

          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryLight)
        ),

        child: Center(
          child: Text(buttonModel.displayText,style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: buttonModel.action == CalcAction.allClear
                ? AppColors.primaryLightest
                : AppColors.primaryDarkest,
          ),),
        ),
      ),
    );
  }
}

class BtnType2 extends StatelessWidget {
  final ButtonModel buttonModel;
  final Function() onItemClick;

  const BtnType2({Key? key, required this.buttonModel, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemClick,
      child: Container(

        decoration: BoxDecoration(
          color: AppColors.primaryLight,

          borderRadius: BorderRadius.circular(8),
        ),

        child: Center(
          child: Text(buttonModel.displayText,style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryDarkest,
          ),),
        ),
      ),
    );
  }
}
