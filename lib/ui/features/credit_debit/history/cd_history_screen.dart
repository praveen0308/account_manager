import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/credit_debit/edit_transaction/edit_cd_transaction.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_footer.dart';
import 'package:account_manager/utils/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

import '../../../../reports/cd_person_history/cd_person_report_preview.dart';
import '../../../../utils/share_utils.dart';

class CDHistory extends StatefulWidget {
  final PersonModel person;

  const CDHistory({Key? key, required this.person}) : super(key: key);

  @override
  State<CDHistory> createState() => _CDHistoryState();
}

class _CDHistoryState extends State<CDHistory> {
  List<CDTransaction> transactions = [];

  @override
  void initState() {
    BlocProvider.of<CdHistoryCubit>(context).personModel = widget.person;
    BlocProvider.of<CdHistoryCubit>(context).fetchTransactions();
    super.initState();
  }

  _showFilters(BuildContext context, TapDownDetails details) {
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
      ],
      elevation: 8.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == 1) {
        BlocProvider.of<CdHistoryCubit>(context).fetchTransactions();
      } else if ([2, 3, 4, 5].contains(itemSelected)) {
        var dates = DateTimeHelper.getDates(itemSelected);
        BlocProvider.of<CdHistoryCubit>(context)
            .fetchTransactions(from: dates[0], to: dates[1]);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.person.name),
        actions: [
          GestureDetector(
              onTapDown: (details) {
                _showFilters(context, details);
              },
              child: const Icon(Icons.filter_alt_rounded)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CDPersonReportPreview(
                      transactions: transactions,
                      person: widget.person,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.picture_as_pdf))
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<CdHistoryCubit, CdHistoryState>(
            listener: (context, state) {
              if (state is DeletedSuccessfully) {
                BlocProvider.of<CdHistoryCubit>(context).fetchTransactions();
              }
            },
            builder: (context, state) {
              if (state is ReceivedTransactions) {
                if (state.transactions.isNotEmpty) {
                  transactions.clear();
                  transactions.addAll(state.transactions);
                  return ListView.builder(
                      itemCount: state.transactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildTransactionView(state.transactions[index]);
                      });
                } else {
                  return const Center(
                    child: Text("No Transactions!!!"),
                  );
                }
              }

              return const CircularProgressIndicator();
            },
          ),
          BlocBuilder<CdHistoryCubit, CdHistoryState>(
            builder: (context, state) {
              return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CDHistoryFooter(
                    person:
                        BlocProvider.of<CdHistoryCubit>(context).personModel,
                  ));
            },
          )
        ],
      ),
    ));
  }

  _showPopupMenu(
      BuildContext context, TapDownDetails details, CDTransaction transaction) {
    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy - 120,
        details.globalPosition.dx,
        details.globalPosition.dy - 120,
      ), //position where you want to show the menu on screen
      items: [
        if (!transaction.isCancel)
          const PopupMenuItem<int>(value: 1, child: Text('Edit')),
        if (!transaction.isCancel)
          const PopupMenuItem<int>(value: 2, child: Text('Delete')),
        if (transaction.isCancel)
          const PopupMenuItem<int>(value: 4, child: Text('Restore')),
        const PopupMenuItem<int>(value: 3, child: Text('Share')),
      ],
      elevation: 8.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == 1) {
        Navigator.pushNamed(context, "/editCDTransaction",
                arguments: EditCDTransactionArgs(widget.person, transaction))
            .then((value) =>
                BlocProvider.of<CdHistoryCubit>(context).fetchTransactions());
      } else if (itemSelected == 2) {
        BlocProvider.of<CdHistoryCubit>(context)
            .updateTransactionStatus(transaction, true);
      } else if (itemSelected == 3) {
        ShareUtil.launchWhatsapp(transaction.getDescription());
      } else if (itemSelected == 4) {
        BlocProvider.of<CdHistoryCubit>(context)
            .updateTransactionStatus(transaction, false);
      } else {}
    });
  }

  Widget buildTransactionView(CDTransaction transaction) {
    bool isCredit = transaction.type == TransactionType.credit.name;

    return ChatBubble(
      alignment: isCredit ? Alignment.bottomLeft : Alignment.bottomRight,
      margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
      backGroundColor:
          transaction.isCancel ? AppColors.greyLight : AppColors.primaryLight,
      clipper: ChatBubbleClipper5(
          type: isCredit ? BubbleType.receiverBubble : BubbleType.sendBubble),
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
            minWidth: MediaQuery.of(context).size.width * 0.5),
        child: Row(
          mainAxisAlignment:
              isCredit ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment:
                  isCredit ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                /*Icon(transaction.walletId == 1
                    ? Icons.looks_one_outlined
                    : Icons.looks_two_outlined),*/
                Text(transaction.remark ?? ""),
                Text(
                  "₹${isCredit ? transaction.credit : transaction.debit}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isCredit ? AppColors.success : AppColors.error),
                ),
                Text(
                  transaction.getClosingBalance(),
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  transaction.getDate(),
                  style: const TextStyle(fontSize: 10),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
                onTapDown: (details) {
                  _showPopupMenu(context, details, transaction);
                },
                child: const Icon(Icons.more_vert_rounded))
          ],
        ),
      ),
    );
  }
}
