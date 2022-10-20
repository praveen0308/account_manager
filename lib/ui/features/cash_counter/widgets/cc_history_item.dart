import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/utils/share_utils.dart';
import 'package:account_manager/widgets/app_dialog.dart';
import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';

import '../dialogs/transaction_detail_dialog.dart';

class CCHistoryItem extends StatelessWidget {
  final CashTransactionModel transactionModel;
  final Function(int transactionId) onDelete;
  final Function(CashTransactionModel cashTransactionModel) onEdit;

  const CCHistoryItem(
      {Key? key,
      required this.transactionModel,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

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
        PopupMenuItem<int>(value: 1, child: Text('View')),
        PopupMenuItem<int>(value: 2, child: Text('Edit')),
        PopupMenuItem<int>(value: 3, child: Text('Delete')),
        PopupMenuItem<int>(value: 4, child: Text('Share')),
      ],
      elevation: 8.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == 1) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AppDialog(
                child: TransactionDetailDialog(
                  data: transactionModel.getFullDescription(),
                ),
              );
            });
      } else if (itemSelected == 2) {
        onEdit(transactionModel);
      } else if (itemSelected == 3) {
        onDelete(transactionModel.transactionID!);
      } else {
        ShareUtil.launchWhatsapp(transactionModel.getFullDescription());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.primaryDarkest),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              Text(
                "₹${transactionModel.grandTotal}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDarkest,
                    fontSize: 16),
              ),
              Text("Note ${transactionModel.noOfNotes}"),
              Text(transactionModel.getTiming())
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
            child: Text(
          transactionModel.getFullDescription(),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        )),
        GestureDetector(
            onTapDown: (details) {
              _showPopupMenu(context, details);
            },
            child: const Icon(Icons.more_vert_rounded)),
      ],
    ));
  }
}
