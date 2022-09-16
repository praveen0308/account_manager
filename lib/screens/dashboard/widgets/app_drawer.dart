import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/text_styles.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.dividerColor,width: 2))
            ),
            child: Column(
              children: [
                const Spacer(),
                Text("Welcome Sir,",style: AppTextStyles.headline6(),),
                const SizedBox(height: 16,)
              ],
            ),
          ),
          getNavItem(Icons.person, "Manage Profile",(){
            debugPrint("Manage Profile");
            Navigator.pop(context);
          }),

          getNavItem(Icons.help, "Help",(){
            debugPrint("Manage Profile");
            Navigator.pop(context);
          }),
          getNavItem(Icons.settings, "Settings",(){
            debugPrint("Settings");
            Navigator.pop(context);
          }),

          getNavItem(Icons.feedback, "Feedback",(){
            debugPrint("FeedBack");
            Navigator.pop(context);
          }),
          getNavItem(Icons.star_rate, "Rate Us",(){
            debugPrint("Rate Us");
            Navigator.pop(context);
          }),

        ],
      ),
    );
  }

  Widget getNavItem(dynamic icon,String text,Function() onTap){
    return InkWell(
      onTap: onTap,
      child: Container(margin: const EdgeInsets.symmetric(horizontal: 8),padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: AppColors.dividerColor))
      ),child: Row(
        children: [
          Icon(icon,size: 28,color: AppColors.primaryDarkest,),
          const SizedBox(width: 16,),
          Text(text,style: AppTextStyles.subtitle2(txtColor: AppColors.primaryText),)
        ],
      ),),
    );
  }
}

