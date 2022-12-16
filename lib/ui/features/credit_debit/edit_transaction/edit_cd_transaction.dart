import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/models/wallet_model.dart';
import 'package:account_manager/ui/features/credit_debit/edit_transaction/edit_cd_transaction_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/edit_transaction/edit_cd_transaction_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/edit_transaction/select_person/select_person.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/outlined_text_field.dart';
import '../../../../widgets/primary_button.dart';

class EditCDTransactionArgs{
  final PersonModel person;
  final CDTransaction transaction;

  EditCDTransactionArgs(this.person, this.transaction);
}
class EditCDTransaction extends StatefulWidget {

  final EditCDTransactionArgs args;
  const EditCDTransaction({Key? key, required this.args})
      : super(key: key);

  @override
  State<EditCDTransaction> createState() => _EditCDTransactionState();
}

class _EditCDTransactionState extends State<EditCDTransaction> {
  TransactionType? _type = TransactionType.credit;
  int _walletId = 1;
  PersonModel? _person;
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _remark = TextEditingController();


  final List<WalletModel> _wallets = AppConstants.getWallets();

  var _activeWallet = "Business 1";
  @override
  void initState() {

    if(widget.args.transaction.type=="OUT"){
      _type = TransactionType.debit;
    }
    _walletId = widget.args.transaction.walletId;
    _activeWallet = "Business $_walletId";
    _person = widget.args.person;
    if(_type==TransactionType.credit){
      _amount.text = widget.args.transaction.credit.toString();
    }
    else{
      _amount.text = widget.args.transaction.debit.toString();
    }
    _remark.text = widget.args.transaction.remark.toString();
    super.initState();
  }

  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit Transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
        child: Form(
            child: BlocConsumer<EditCdTransactionCubit, EditCdTransactionState>(
          listener: (context, state) {
            if(state is UpdatedSuccessfully){
              showToast("Updated successfully!!",ToastType.success);
              Navigator.pop(context,true);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<TransactionType>(
                        title: const Text('Credit'),
                        value: TransactionType.credit,
                        groupValue: _type,
                        onChanged: (TransactionType? value) {
                          setState(() {
                            _type = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<TransactionType>(
                        title: const Text('Debit'),
                        value: TransactionType.debit,
                        groupValue: _type,
                        onChanged: (TransactionType? value) {
                          setState(() {
                            _type = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: _wallets
                          .map((item) => DropdownMenuItem<String>(
                        value: item.name,
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ))
                          .toList(),
                      value: _activeWallet,
                      onChanged: (value) {
                        setState(() {
                          _activeWallet = value as String;
                          _walletId = int.parse(_activeWallet[-1]);
                        });

                      },
                      buttonHeight: 40,
                      itemHeight: 40,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: AppColors.primaryDarkest,
                            width: 1.5
                        ),
                        color: Colors.white,
                      ),

                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),


                      ),
                    )),
                ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, "/selectPerson",arguments: SelectPersonArgs(_walletId,_person!)).then((value){
                      _person = value as PersonModel;
                    });
                  },
                  leading: CircleAvatar(
                    child: Text(_person!.name[0]),
                  ),
                  title: Text(_person!.name),
                  trailing: const Icon(Icons.chevron_right),
                ),
                /*DropdownSearch<PersonModel>(

                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,

                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(labelText: "User by name"),
                  ),
                  selectedItem: _person,
                  asyncItems: (String filter) async {
                    var response = await BlocProvider.of<EditCdTransactionCubit>(context).fetchPersonsByWalletId(_walletId);

                    return response;
                  },
                  onChanged: (PersonModel? data) {
                    print(data);
                    _person = data;
                  },
                ),*/

                label("Amount"),
                OutlinedTextField(
                  controller: _amount,
                  inputType: TextInputType.number,
                  maxLength: 10,
                  hintText: "Amount",
                  onTextChanged: (String txt) {},
                  onSubmitted: (String txt) {},
                ),
                label("Remark"),
                OutlinedTextField(
                  controller: _remark,
                  inputType: TextInputType.text,
                  maxLength: 50,
                  hintText: "Remark",
                  onTextChanged: (String txt) {},
                  onSubmitted: (String txt) {},
                ),

                const SizedBox(
                  height: 16,
                ),
                const Spacer(),
                if (state is Updating)
                  const Center(child: CircularProgressIndicator()),
                if (state is! Updating)
                  PrimaryButton(
                      onClick: () {

                        BlocProvider.of<EditCdTransactionCubit>(context)
                            .updateCDTransaction(
                            _person!,
                            CDTransaction(
                              transactionId: widget.args.transaction.transactionId,
                                walletId: _walletId,
                                credit: _type==TransactionType.credit? double.parse(_amount.text):0,
                                debit: _type==TransactionType.debit? double.parse(_amount.text):0,
                                remark: _remark.text,
                                personId: _person!.personId!,
                                type: _type==TransactionType.credit?"IN":"OUT"
                            ));
                      },
                      text: "Update"),
              ],
            );
          },
        )),
      ),
    ));
  }
}
