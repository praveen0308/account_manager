import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';

class CCHistoryItem extends StatelessWidget {
  final CashTransactionModel transactionModel;

  const CCHistoryItem({Key? key, required this.transactionModel})
      : super(key: key);

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
            borderRadius: BorderRadius.circular(4)
          ),
          child: Column(
            children: [
              Text("₹${transactionModel.grandTotal}",style: const TextStyle(fontWeight: FontWeight.w600,color: AppColors.primaryDarkest,fontSize: 16),),
              Text("Note ${transactionModel.noOfNotes}"),
              Text(transactionModel.getTiming())
            ],
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(child: Text(transactionModel.getFullDescription(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),
        IconButton(padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
      ],
    ));
  }
}
