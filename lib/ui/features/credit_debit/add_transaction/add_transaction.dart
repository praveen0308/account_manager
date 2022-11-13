import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/ui/features/credit_debit/add_transaction/add_transaction_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/history/cd_history_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/outlined_text_field.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/primary_button.dart';

class AddCDTransactionForm extends StatefulWidget {
  final PersonModel person;
  final TransactionType type;

  const AddCDTransactionForm(
      {Key? key, required this.person, required this.type})
      : super(key: key);

  @override
  State<AddCDTransactionForm> createState() => _AddCDTransactionFormState();
}

class _AddCDTransactionFormState extends State<AddCDTransactionForm> {
  final TextEditingController _txtAmountController = TextEditingController();
  final TextEditingController _txtRemarkController = TextEditingController();

  bool isValid = true;
  int selectedWalletId = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTransactionCubit, AddTransactionState>(
      listener: (context, state) {
        if (state is AddedSuccessfully) {
          _txtAmountController.text = "";
          _txtAmountController.text = "";
          BlocProvider.of<CdHistoryCubit>(context).personModel = state.result;
          BlocProvider.of<CdHistoryCubit>(context).fetchTransactions();
          ScaffoldMessenger.of(context)
              .showToast("Added successfully!!!", ToastType.success);
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 350,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              Text(
                widget.type == "IN" ? "Receive(IN)" : "Give(OUT)".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              OutlinedTextField(
                  controller: _txtAmountController,
                  onTextChanged: (txt) {},
                  onSubmitted: (txt) {},
                  inputType: TextInputType.number,
                  maxLength: 7,
                  hintText: "Enter Amount"),
              OutlinedTextField(
                controller: _txtRemarkController,
                onTextChanged: (txt) {},
                onSubmitted: (txt) {},
                inputType: TextInputType.text,
                maxLength: 50,
                hintText: "Remark",
              ),
              /*Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: WalletGroup(
                    onWalletSelected: (int selectedWallet) {
                      selectedWalletId = selectedWallet;
                    },
                  )),*/
              Visibility(
                  visible: !isValid,
                  child: const Text(
                    "Invalid data !!!",
                    style: TextStyle(color: Colors.red),
                  )),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                      child: SecondaryButton(
                          onClick: () {
                            Navigator.pop(context, false);
                          },
                          text: "Cancel")),
                  const SizedBox(width: 8),
                  Expanded(
                      child: PrimaryButton(
                          onClick: () {
                            String amount = _txtAmountController.text;
                            String remark = _txtRemarkController.text;

                            if (amount.isNotEmpty && remark.isNotEmpty) {
                              setState(() {
                                isValid = true;
                              });

                              if (widget.type == TransactionType.credit) {
                                BlocProvider.of<AddTransactionCubit>(context)
                                    .addNewTransaction(
                                        widget.person,
                                        CDTransaction(
                                          walletId: widget.person.walletId,
                                          credit: double.parse(amount),
                                          remark: remark,
                                          personId: widget.person.personId!,
                                          type: widget.type.name
                                        ));
                              } else {
                                BlocProvider.of<AddTransactionCubit>(context)
                                    .addNewTransaction(
                                        widget.person,
                                        CDTransaction(
                                          walletId: selectedWalletId,
                                          debit: double.parse(amount),
                                          remark: remark,
                                          personId: widget.person.personId!,
                                            type: widget.type.name
                                        ));
                              }
                            } else {
                              setState(() {
                                isValid = false;
                              });
                            }
                          },
                          text: "Save"))
                ],
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        );
      },
    );
  }
}

class Wallet {
  static const group = 1;
  static const wallet1Id = 1;
  static const wallet2Id = 2;

  static const wallet1 = "Wallet 1";
  static const wallet2 = "Wallet 2";
}

class WalletGroup extends StatefulWidget {
  final Function(int selectedWallet) onWalletSelected;

  const WalletGroup({Key? key, required this.onWalletSelected})
      : super(key: key);

  @override
  State<WalletGroup> createState() => _WalletGroupState();
}

class _WalletGroupState extends State<WalletGroup> {
  int selectedWalletId = 1;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Add into",
        style: TextStyle(fontSize: 19),
      ),
      Row(
        children: [
          Expanded(
            child: RadioListTile<int>(
              contentPadding: const EdgeInsets.all(0),
              title: const Text(Wallet.wallet1),
              value: Wallet.wallet1Id,
              groupValue: selectedWalletId,
              onChanged: (int? value) {
                setState(() {
                  // Update map value on tap
                  selectedWalletId = value!;
                  widget.onWalletSelected(selectedWalletId);
                });
              },
            ),
          ),
          Expanded(
            child: RadioListTile<int>(
              contentPadding: const EdgeInsets.all(0),
              title: const Text(Wallet.wallet2),
              value: Wallet.wallet2Id,
              groupValue: selectedWalletId,
              onChanged: (int? value) {
                setState(() {
                  // Update map value on tap
                  selectedWalletId = value!;
                  widget.onWalletSelected(selectedWalletId);
                });
              },
            ),
          ),
        ],
      ),
    ]);
  }
}
