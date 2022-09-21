import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerLight extends StatelessWidget {
  final Widget childWidget;
  final VoidCallback? onClick;
  const ContainerLight({Key? key, required this.childWidget, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryLightest,
          borderRadius: BorderRadius.circular(8)
        ),
        child: childWidget,
      ),
    );
  }
}
