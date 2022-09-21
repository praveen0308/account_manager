import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:account_manager/route/route.dart' as route;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: const IconThemeData(color: AppColors.primaryDarkest),
          primarySwatch: AppColors.primarySwatchColor,
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent,
          ),
          textTheme: TextTheme(),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
              titleTextStyle: TextStyle(
                  color: AppColors.primaryDarkest,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              iconTheme: IconThemeData(color: AppColors.primaryDarkest,size: 32))),
      initialRoute: route.splashScreen,
      onGenerateRoute: route.controller,
    );
  }
}
