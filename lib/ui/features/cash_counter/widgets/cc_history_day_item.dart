import 'package:account_manager/models/day_transaction_model.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/cash_counter/dialogs/transaction_detail_dialog.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cc_history_item.dart';
import 'package:account_manager/utils/share_utils.dart';
import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';

import '../../../../models/cash_transaction.dart';
import '../../../../widgets/app_dialog.dart';

class CCHistoryDayItem extends StatefulWidget {
  final DayTransactionModel dayTransaction;
  final Function(CashTransactionModel cashTransactionModel) onEdit;
  final Function(int transactionId) onDelete;

  const CCHistoryDayItem(
      {Key? key,
      required this.dayTransaction,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  State<CCHistoryDayItem> createState() => _CCHistoryDayItemState();
}

class _CCHistoryDayItemState extends State<CCHistoryDayItem> {
  bool isExpanded = false;
  double total = 0.0;

  @override
  void initState() {
    for (var element in widget.dayTransaction.cashTransactions) {
      total += element.grandTotal;
    }
    super.initState();
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      child: Column(
        children: [
          // Header
          GestureDetector(
              onTap: toggleExpansion,
              child: Row(
                children: [
                  /*IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        // TODO delete day transactions
                      },
                      icon: const Icon(Icons.delete)),*/
                  IconButton(
                      onPressed: () {
                        ShareUtil.launchWhatsapp(
                            widget.dayTransaction.getFullDescription());
                      },
                      icon: const Icon(Icons.share)),
                  Expanded(
                      child: Text(
                    widget.dayTransaction.date,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  )),
                  IconButton(
                      onPressed: toggleExpansion,
                      icon: const Icon(Icons.keyboard_arrow_down)),
                ],
              )),

          // Body
          Container(
              child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.dayTransaction.cashTransactions.length,
            itemBuilder: (context, index) {
              final transaction = widget.dayTransaction.cashTransactions[index];
              return CCHistoryItem(
                transactionModel: transaction,
                onEdit: widget.onEdit,
                onDelete:widget.onDelete,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 4,
              );
            },
          )),
          // Footer
          Container(
            child: Row(
              children: [
                const Text("Balance of Day : "),
                Text(
                  "₹$total",
                  style: const TextStyle(
                      color: AppColors.primaryDarkest,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AppDialog(
                              child: TransactionDetailDialog(
                                data:
                                    widget.dayTransaction.getFullDescription(),
                              ),
                            );
                          });
                    },
                    child: const Text(
                      "Total Note",
                      style: TextStyle(color: AppColors.primaryDarkest),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
