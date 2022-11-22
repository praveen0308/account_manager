import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/ui/features/cash_counter/history/cc_history_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/history/footer.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cc_history_day_item.dart';
import 'package:account_manager/utils/date_time_helper.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/list_data_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/cash_transaction.dart';
import '../../../../reports/cash_transaction_preview.dart';

class CCHistoryScreen extends StatefulWidget {
  const CCHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CCHistoryScreen> createState() => _CCHistoryScreenState();
}

class _CCHistoryScreenState extends State<CCHistoryScreen> with RestorationMixin{
  @override
  String? get restorationId => "CashTransactionsFilter";
  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime(2022));
  final RestorableDateTimeN _endDate =
  RestorableDateTimeN(DateTime(2030));
  late final RestorableRouteFuture<DateTimeRange?>
  _restorableDateRangePickerRouteFuture =
  RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;

        BlocProvider.of<CcHistoryCubit>(context).fetchTransactions(from: _startDate.value!.millisecondsSinceEpoch,to:_endDate.value!.millisecondsSinceEpoch);
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTimeRange?> _dateRangePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
          _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime(2022),

          lastDate: DateTime(2030),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }

    return null;
  }

  List<CashTransactionModel> transactions = [];
  _showPopupMenu(BuildContext context, TapDownDetails details) {
    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy - 120,
        details.globalPosition.dx,
        details.globalPosition.dy - 120,
      ), //position where you want to show the menu on screen
      items: const [
        PopupMenuItem<int>(value: 1, child: Text('All time')),
        PopupMenuItem<int>(value: 2, child: Text('Last week')),
        PopupMenuItem<int>(value: 3, child: Text('Last month')),
        PopupMenuItem<int>(value: 4, child: Text('Last 3 months')),
        PopupMenuItem<int>(value: 5, child: Text('Last year')),
        PopupMenuItem<int>(value: 6, child: Text('Custom')),
      ],
      elevation: 8.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == 1) {
        BlocProvider.of<CcHistoryCubit>(context).fetchTransactions();
      } else if ([2,3,4,5].contains(itemSelected)) {
        var dates = DateTimeHelper.getDates(itemSelected);
        BlocProvider.of<CcHistoryCubit>(context).fetchTransactions(from: dates[0],to:dates[1]);
      } else {
        _restorableDateRangePickerRouteFuture.present();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.cashTransactions),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ListDataHeader(
                  onSearched: (String q) {},
                  onFilterClicked: (TapDownDetails details) {
                    _showPopupMenu(context, details);
                  },
                  onPdfClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PdfPreviewPage(transactions:transactions),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: BlocConsumer<CcHistoryCubit, CcHistoryState>(
                    listener: (context, state) {
                      if (state is DeletedSuccessfully) {
                        showToast(
                            "Deleted successfully !!!", ToastType.success);
                        BlocProvider.of<CcHistoryCubit>(context)
                            .fetchTransactions();
                      }
                    },
                    builder: (context, state) {
                      if (state is Error) {
                        return Center(
                          child: Text(state.msg),
                        );
                      }
                      if (state is ReceivedHistory) {
                        if (state.data.isNotEmpty) {
                          transactions.clear();
                          transactions.addAll(BlocProvider.of<CcHistoryCubit>(context).transactions);
                          return ListView.separated(
                            padding: const EdgeInsets.only(bottom: 120),
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              var dayTransaction = state.data[index];
                              return CCHistoryDayItem(
                                dayTransaction: dayTransaction,
                                onEdit: (CashTransactionModel
                                    cashTransactionModel) {},
                                onDelete: (int transactionId) {
                                  BlocProvider.of<CcHistoryCubit>(context)
                                      .deleteTransaction(transactionId);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.note_add,
                                size: 50,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text("No transactions added!!!")
                            ],
                          );
                        }
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
          const Positioned(bottom: 0, left: 0, right: 0, child: Footer())
        ],
      ),
    ));
  }

  @override
  void initState() {
    BlocProvider.of<CcHistoryCubit>(context).fetchTransactions();
    super.initState();
  }
}
