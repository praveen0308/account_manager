import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cc_history_item.dart';
import 'package:account_manager/widgets/outlined_container.dart';
import 'package:flutter/material.dart';

import '../../../../models/cash_transaction.dart';

class CCHistoryDayItem extends StatefulWidget {
  final List<CashTransactionModel> data;

  const CCHistoryDayItem({Key? key, required this.data}) : super(key: key);

  @override
  State<CCHistoryDayItem> createState() => _CCHistoryDayItemState();
}

class _CCHistoryDayItemState extends State<CCHistoryDayItem> {
  bool isExpanded = false;
  double total = 0.0;

  @override
  void initState() {
    widget.data.forEach((element) {
      total += element.grandTotal;
    });
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
              child: Container(
                child: Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {},
                        icon: const Icon(Icons.delete)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                    Expanded(
                        child: Text(
                      widget.data[0].getDate(),
                      textAlign: TextAlign.center,
                    )),
                    IconButton(
                        onPressed: toggleExpansion,
                        icon: const Icon(Icons.keyboard_arrow_down)),
                  ],
                ),
              )),

          // Body
          Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    final transaction = widget.data[index];
                    return CCHistoryItem(transactionModel: transaction);
                  })),
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
                    onPressed: () {},
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
