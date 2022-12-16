import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/ui/features/pick_person/pick_person_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/credit_debit_transaction.dart';
import '../../../res/app_colors.dart';

class PickPersonScreen extends StatefulWidget {
  final CashTransactionModel transaction;

  const PickPersonScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<PickPersonScreen> createState() => _PickPersonScreenState();
}

class _PickPersonScreenState extends State<PickPersonScreen> {
  var activeBusiness = "Business 1";

  final List<String> _businessList = ["Business 1", "Business 2", "Business 3"];

  @override
  void initState() {
    BlocProvider.of<PickPersonCubit>(context)
        .fetchPersonsByWalletId(getActiveWalletId(activeBusiness.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Pick A Person"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonHideUnderline(
                child: DropdownButton2(
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: _businessList
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ))
                  .toList(),
              value: activeBusiness,
              onChanged: (value) {
                BlocProvider.of<PickPersonCubit>(context)
                    .fetchPersonsByWalletId(
                        getActiveWalletId(value.toString()));
                setState(() {
                  activeBusiness = value as String;
                });
              },
              buttonHeight: 40,
              itemHeight: 40,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.primaryDarkest, width: 1.5),
                color: Colors.white,
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
            )),
            BlocConsumer<PickPersonCubit, PickPersonState>(
                builder: (context, state) {
                  if (state is LoadingPersons || state is AddingTransaction) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is NoPersons) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.hourglass_empty,
                            size: 60,
                          ),
                          Text("No Person!!"),
                        ],
                      ),
                    );
                  }
                  if (state is ReceivedPersons) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.persons.length,
                        itemBuilder: (context, index) {
                          PersonModel person = state.persons[index];
                          return ListTile(
                            leading: CircleAvatar(child: Text(person.name[0])),
                            title: Text(person.name),
                            onTap: () {
                              BlocProvider.of<PickPersonCubit>(context)
                                  .addNewTransaction(
                                      person,
                                      CDTransaction(
                                          walletId:
                                              getActiveWalletId(activeBusiness),
                                          debit: widget.transaction.grandTotal,
                                          remark: widget.transaction.remark,
                                          personId: person.personId!,
                                          type: "debit"));
                            },
                          );
                        });
                  }
                  return const Center(
                    child: Text("Something went wrong!!!"),
                  );
                },
                listener: (context, state) {
                  if(state is AddedTransaction){
                    showToast("Transaction added successfully!!!",ToastType.success);
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
    ));
  }

  int getActiveWalletId(String value) {
    switch (value) {
      case "Business 1":
        return 1;
      case "Business 2":
        return 2;
      case "Business 3":
        return 3;
      default:
        return 1;
    }
  }
}
