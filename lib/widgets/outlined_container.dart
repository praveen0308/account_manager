import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class OutlinedContainer extends StatelessWidget {
  final Widget childWidget;
  final VoidCallback? onClick;
  const OutlinedContainer({Key? key, required this.childWidget, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryLightest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryDarkest,width: 2)
      ),
      child: childWidget,
    );
  }
}
