import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final Function() onItemClick;
  const DashboardItem({Key? key, required this.iconUrl, required this.title, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemClick,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLightest,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconUrl,color: AppColors.primaryDarkest,height: 48,width: 48,),
            const SizedBox(height: 16,),
            Text(title,textAlign: TextAlign.center,style: AppTextStyles.subtitle1(wFont: FontWeight.w400,txtColor: AppColors.primaryText),)
          ],
        ),
      ),
    );
  }
}

class HrDashboardItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final Function() onItemClick;
  const HrDashboardItem({Key? key, required this.iconUrl, required this.title, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: AppColors.primaryLightest,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            SvgPicture.asset(iconUrl,color: AppColors.primaryDarkest,height: 48,width: 48,),
            const SizedBox(width: 16,),
            Text(title,textAlign: TextAlign.center,style: AppTextStyles.subtitle1(wFont: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}

