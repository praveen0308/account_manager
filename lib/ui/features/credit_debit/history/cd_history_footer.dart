import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/credit_debit/add_transaction/add_transaction.dart';
import 'package:account_manager/ui/features/credit_debit/add_transaction/add_transaction_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/footer_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/share_utils.dart';
import 'cd_history_cubit.dart';

class CDHistoryFooter extends StatefulWidget {
  final PersonModel person;

  const CDHistoryFooter({Key? key, required this.person}) : super(key: key);

  @override
  State<CDHistoryFooter> createState() => _CDHistoryFooterState();
}

class _CDHistoryFooterState extends State<CDHistoryFooter> {
  _displayDialog(TransactionType type) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: BlocProvider.value(
              value: BlocProvider.of<CdHistoryCubit>(this.context),
              child: BlocProvider(
                create: (context) => AddTransactionCubit(
                    RepositoryProvider.of<CreditDebitRepository>(context)),
                child: AddCDTransactionForm(person: widget.person, type: type),
              ),
            ),
          );
        }).then((value) {
          if(value[0]){
            PersonModel person = value[1];
            CDTransaction cdTransaction = value[2];
            cdTransaction.closingBalance = person.credit-person.debit;
            ShareUtil.launchWhatsapp1(cdTransaction.getDescription(), person.mobileNumber);
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    double balance = widget.person.credit - widget.person.debit;
    return FooterContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  "Cr : ₹${widget.person.credit}",
                  style: const TextStyle(
                      color: AppColors.success, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: (){
                    _displayDialog(TransactionType.credit);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 48,
                      color: AppColors.white,
                    ),
                  ),
                ),

                /*ElevatedButton.icon(
                    onPressed: () {
                      _displayDialog(TransactionType.credit);
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 32,
                      color: AppColors.white,
                    ),
                    label: const Text(
                      "Receive(In)",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.success),
                    )),*/
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "₹$balance",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Text(
                    balance < 0 ? "Due" : "Advance",
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  "Db : ₹${widget.person.debit}",
                  style: const TextStyle(
                      color: AppColors.error, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: (){
                    _displayDialog(TransactionType.debit);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 48,
                      color: AppColors.white,
                    ),
                  ),
                ),
                /*ElevatedButton.icon(
                    onPressed: () {
                      _displayDialog(TransactionType.debit);
                    },
                    icon: const Icon(
                      Icons.arrow_drop_up,
                      size: 32,
                      color: AppColors.white,
                    ),
                    label: const Text(
                      "Give(Out)",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.error),
                    )),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
