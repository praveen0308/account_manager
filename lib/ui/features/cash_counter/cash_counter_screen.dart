import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:account_manager/repository/currency_repository.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/ui/features/cash_counter/cash_calculator_view/cash_calculator_view_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cash_counter_footer.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/extra_info_form.dart';
import 'package:account_manager/ui/features/pick_person/pick_person_cubit.dart';
import 'package:account_manager/ui/features/pick_person/pick_person_screen.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/credit_debit_transaction.dart';
import '../../../utils/share_utils.dart';
import 'cash_calculator_view/cash_counter_view.dart';

class CashCounterScreen extends StatefulWidget {
  const CashCounterScreen({Key? key}) : super(key: key);

  @override
  State<CashCounterScreen> createState() => _CashCounterScreenState();
}

class _CashCounterScreenState extends State<CashCounterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<CashCounterCubit, CashCounterState>(
        listener: (context, state) {
          if (state is TransactionAddedSuccessfully) {
            ScaffoldMessenger.of(context).showToast(
                "Transaction added successfully!!!", ToastType.success);
            if (state.addIntCD) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => PickPersonCubit(
                                RepositoryProvider.of<CreditDebitRepository>(
                                    context)),
                            child: PickPersonScreen(
                                transaction: state.savedTransaction),
                          ))).then((value) {
                if (value[0]) {
                  PersonModel person = value[1];
                  CDTransaction cdTransaction = value[2];
                  ShareUtil.launchWhatsapp1(
                      cdTransaction.getDescription(), person.mobileNumber);
                }
              });
            }
          }
          if (state is TransactionFailed) {
            ScaffoldMessenger.of(context)
                .showToast("Failed to add transaction !!!", ToastType.error);
          }
          if (state is ClearScreen) {
            setState(() {});
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocProvider(
                      create: (context) => CashCalculatorViewCubit(
                          RepositoryProvider.of<CurrencyRepository>(context),
                          BlocProvider.of<CashCounterCubit>(context)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CashCounterView(
                          onQtyChanged: (int item, int qty) {
                            BlocProvider.of<CashCounterCubit>(context)
                                .updateNoteQty(item, qty);
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.primaryDarkest,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ExtraInfoForm(),
                    ),
                    Container(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),
            const CCBottomSheet()
          ],
        ),
      ),
    ));
  }
}
