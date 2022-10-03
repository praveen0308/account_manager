import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;

  const PrimaryButton({Key? key, required this.onClick, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      height: 50,
      onPressed: onClick,

      color: AppColors.primaryDarkest,
      textColor: AppColors.primaryLightest,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          ),
      child: Text(text,style: const TextStyle(fontSize: 18),),
    );
  }
}
