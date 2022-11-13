import 'package:account_manager/models/wallet_model.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/credit_debit/add_person/add_person_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/add_person/add_person_form.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/widgets/wallet_view.dart';
import 'package:account_manager/widgets/outlined_text_field.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

class CreditDebitFooter extends StatefulWidget {
  const CreditDebitFooter({Key? key}) : super(key: key);

  @override
  State<CreditDebitFooter> createState() => _CreditDebitFooterState();
}

class _CreditDebitFooterState extends State<CreditDebitFooter> {
  double grandTotal = 0.0;
  double credit = 0.0;
  double debit = 0.0;


  _showBusinessMenu(BuildContext context, TapDownDetails details) {
    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy - 200,
        details.globalPosition.dx,
        details.globalPosition.dy - 120,
      ), //position where you want to show the menu on screen
      items: const [
        PopupMenuItem<int>(value: 1, child: Text('Business 1')),
        PopupMenuItem<int>(value: 2, child: Text('Business 2')),
        PopupMenuItem<int>(value: 3, child: Text('Business 3')),
      ],
      elevation: 8.0,
    ).then<void>((int? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == 1) {
        BlocProvider.of<CreditDebitCubit>(context).fetchPersonsByWalletId(1);
      } else if (itemSelected == 2) {
        BlocProvider.of<CreditDebitCubit>(context).fetchPersonsByWalletId(2);
      } else {
        BlocProvider.of<CreditDebitCubit>(context).fetchPersonsByWalletId(3);
      }
    });
  }

  _displayDialog() {
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
              value: BlocProvider.of<CreditDebitCubit>(this.context),
              child: BlocProvider(
                create: (context) => AddPersonCubit(
                    RepositoryProvider.of<CreditDebitRepository>(context)),
                child: const AddPersonForm(),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          border: Border.all(color: AppColors.dividerColor)),
      child: BlocBuilder<CreditDebitCubit, CreditDebitState>(
        builder: (context, state) {
          if (state is ReceivedStats) {

              grandTotal = state.grandTotal;
              credit = state.credit;
              debit = state.debit;


          }

          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cr. : +₹$credit",
                    style: const TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Text("Db. : -₹$debit",
                      style: const TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.w500,
                          fontSize: 18)),
                  Text(
                    "Total : ₹$grandTotal",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTapDown: (details){
                      _showBusinessMenu(context, details);
                    },
                    child: OutlinedButton(
                        onPressed: () {

                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              width: 2.0, color: AppColors.primaryDark),
                        ),
                        child: Text("Business ${
                          BlocProvider.of<CreditDebitCubit>(context)
                              .activeWalletId
                        }")),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _displayDialog();
                    },
                    icon: const Icon(
                      Icons.person_add,
                      color: AppColors.white,
                    ),
                    label: const Text(
                      "Add Person",
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryDarkest)),
                  )
                ],
              ),
              /*Column(
              children: [
                Row(
                  children: [
                    Expanded(child: WalletView(walletModel: w1, color: Colors.blue,)),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(child: WalletView(walletModel: w2,color: Colors.red,)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                  ],
                )
              ],
            ),*/
            ],
          );
        },


      ),
    );
  }
}
