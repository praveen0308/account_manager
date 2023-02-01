import 'package:account_manager/local/secure_storage.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/app_icons.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/res/text_styles.dart';
import 'package:account_manager/ui/screens/dashboard/widgets/app_drawer.dart';
import 'package:account_manager/ui/screens/dashboard/widgets/dashboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:account_manager/route/route.dart' as route;
import 'package:share_plus/share_plus.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SecureStorage _secureStorage = SecureStorage();
  bool _isSecured = false;

  @override
  void initState() {
    _secureStorage.getPin().then((value) {
      _isSecured = value != null;
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            /*appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              ),
            ),*/
            drawer: const AppDrawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  Text(
                    "Welcome",
                    style: AppTextStyles.headline5(
                        txtColor: AppColors.primaryText),
                  ),
                  Text(
                    "What would you like to do?",
                    style: AppTextStyles.headline6(
                        txtColor: AppColors.primaryText),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  StaggeredGrid.count(
                    crossAxisCount: 3,
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
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icIncome,
                            title: AppStrings.incomeExpense,
                            onItemClick: () {
                              Navigator.pushNamed(context, route.incomeExpense);
                            }),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icNote,
                            title: AppStrings.notes,
                            onItemClick: () {
                              // Navigator.pushNamed(context, route.notes);
                              if (_isSecured) {
                                Navigator.pushNamed(
                                    context, route.pinAuthentication).then((value){
                                  _secureStorage.getPin().then((value) {
                                    _isSecured = value != null;
                                  });
                                });
                              } else {
                                Navigator.pushNamed(context, route.createPin,
                                    arguments: true).then((value){
                                  _secureStorage.getPin().then((value) {
                                    _isSecured = value != null;
                                  });
                                });
                              }
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>const RememberPassword()));
                            }),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icBackup,
                            title: AppStrings.backupNRestore,
                            onItemClick: () {
                              Navigator.pushNamed(
                                  context, route.backupNRestore);
                            }),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icFeedback,
                            title: AppStrings.feedBack,
                            onItemClick: () {
                              Navigator.pushNamed(
                                  context, route.feedback);
                            }),
                      ),

                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: DashboardItem(
                            iconUrl: AppIcons.icShare,
                            title: AppStrings.shareNow,
                            onItemClick: () {
                              Share.share('Check out this application https://example.com', subject: 'Account Manager');
                            }),
                      ),
                      /*StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 0.7,
                        child: HrDashboardItem(
                            iconUrl: AppIcons.icIncome,
                            title: AppStrings.backupNRestore,
                            onItemClick: () {
                              Navigator.pushNamed(
                                  context, route.backupNRestore);
                            }),
                      ),*/
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            )));
  }
}
