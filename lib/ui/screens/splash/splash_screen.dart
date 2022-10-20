import 'dart:async';

import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/app_images.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:account_manager/route/route.dart' as route;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, route.dashboard1);
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.greyLightest,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.greyLightest,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.colorTransparent));
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.primaryLightest,
                borderRadius: BorderRadius.circular(100)
              ),
                child: Image.asset(
              AppImages.appIcon,
              height: 110,
              width: 110,
            )),
            const Spacer(
              flex: 2,
            ),
            Text(
              AppStrings.appName,
              style: AppTextStyles.headline5(),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              AppStrings.poweredBy,
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
