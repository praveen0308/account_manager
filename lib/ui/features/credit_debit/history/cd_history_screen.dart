import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

class CDHistory extends StatefulWidget {
  final PersonModel person;

  const CDHistory({Key? key, required this.person}) : super(key: key);

  @override
  State<CDHistory> createState() => _CDHistoryState();
}

class _CDHistoryState extends State<CDHistory> {
  @override
  void initState() {
    BlocProvider.of<CdHistoryCubit>(context).personModel = widget.person;
    BlocProvider.of<CdHistoryCubit>(context).fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.person.name),
      ),
      body: Stack(
        children: [
          Expanded(
            child: BlocBuilder<CdHistoryCubit, CdHistoryState>(
              builder: (context, state) {
                if (state is ReceivedTransactions) {
                  if (state.transactions.isNotEmpty) {
                    return ListView.builder(
                        itemCount: state.transactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildTransactionView(
                              state.transactions[index]);
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
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CDHistoryFooter(
                person: widget.person,
              ))
        ],
      ),
    ));
  }

  Widget buildTransactionView(CDTransaction transaction) {
    bool isCredit = transaction.type == TransactionType.credit.name;

    return ChatBubble(
      alignment: isCredit ? Alignment.bottomLeft : Alignment.bottomRight,
      margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
      backGroundColor: AppColors.primaryLight,
      clipper: ChatBubbleClipper5(
          type: isCredit ? BubbleType.receiverBubble : BubbleType.sendBubble),
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.5,
        ),
        child: Row(
          mainAxisAlignment:
              isCredit ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment:
                  isCredit ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Icon(transaction.walletId == 1 ? Icons.looks_one_outlined:Icons.looks_two_outlined),

                Text(transaction.remark ?? ""),
                Text(
                  "₹${isCredit ? transaction.credit : transaction.debit}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isCredit ? AppColors.success : AppColors.error),
                ),
                Text(
                  "Cls Bal. ₹${transaction.closingBalance}",
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
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
          ],
        ),
      ),
    );
  }
}
