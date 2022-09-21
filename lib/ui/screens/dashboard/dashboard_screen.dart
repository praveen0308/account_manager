import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/app_icons.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/res/text_styles.dart';
import 'package:account_manager/ui/screens/dashboard/widgets/app_drawer.dart';
import 'package:account_manager/ui/screens/dashboard/widgets/dashboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:account_manager/route/route.dart' as route;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              ),
            ),
            drawer: const AppDrawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  Text(
                    "Good Morning",
                    style: AppTextStyles.headline5(
                        txtColor: AppColors.primaryText),
                  ),
                  Text(
                    "What would you like to do?",
                    style: AppTextStyles.headline6(
                        txtColor: AppColors.primaryText),
                  ),
                  /*Row(
                    children: [
                      DashboardItem(iconUrl: AppIcons.icGSTCalculator, title: AppStrings.gstCalculator, onItemClick: (){}),
                      DashboardItem(iconUrl: AppIcons.icCash, title: AppStrings.cashCounter, onItemClick: (){}),
                    ],
                  )*/
                  const SizedBox(
                    height: 32,
                  ),
                  StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icGSTCalculator,
                            title: AppStrings.gstCalculator,
                            onItemClick: () {
                              Navigator.pushNamed(context, route.gstCalculator);
                            }),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icCash,
                            title: AppStrings.cashCounter,
                            onItemClick: () {
                              Navigator.pushNamed(context, route.cashCounter);
                            }),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icTransaction,
                            title: AppStrings.creditDebit,
                            onItemClick: () {
                              Navigator.pushNamed(context, route.creditDebit);
                            }),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icEmiCalculator,
                            title: AppStrings.emiCalculator,
                            onItemClick: () {
                              Navigator.pushNamed(context, route.emiCalculator);
                            }),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 0.7,
                        child: HrDashboardItem(
                            iconUrl: AppIcons.icIncome,
                            title: AppStrings.incomeExpense,
                            onItemClick: () {
                              Navigator.pushNamed(context, route.incomeExpense);
                            }),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
