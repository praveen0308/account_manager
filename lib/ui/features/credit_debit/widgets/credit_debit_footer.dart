import 'package:account_manager/models/wallet_model.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/credit_debit/add_person/add_person_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/add_person/add_person_form.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/widgets/wallet_view.dart';
import 'package:account_manager/widgets/outlined_text_field.dart';
import 'package:account_manager/widgets/primary_button.dart';
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
  WalletModel w1 = WalletModel(1, "business", 0, 0);
  WalletModel w2 = WalletModel(2, "current", 0, 0);

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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          border: Border.all(color: AppColors.dividerColor)),
      child: BlocListener<CreditDebitCubit, CreditDebitState>(
        listener: (context, state) {
          if (state is ReceivedStats) {
            setState(() {
              grandTotal = state.grandTotal;
              w1 = state.wallet1;
              w2 = state.wallet2;
            });
          }
        },
        child: Column(
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
                Text(
                  "Total : ₹$grandTotal",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
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
            )
          ],
        ),
      ),
    );
  }
}
