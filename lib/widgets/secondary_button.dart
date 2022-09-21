import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;

  const SecondaryButton({Key? key, required this.onClick, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      onPressed: onClick,

      color: AppColors.white,
      textColor: AppColors.primaryDarkest,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 2,color: AppColors.primaryDarkest),
        borderRadius: BorderRadius.circular(8.0),

      ),
      child: Text(text,style: const TextStyle(fontSize: 18),),
    );
  }
}
