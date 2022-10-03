import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';

class FooterContainer extends StatelessWidget {
  final Widget child;

  const FooterContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            border: Border.all(color: AppColors.dividerColor)),
        child: child);
  }
}
