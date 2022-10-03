import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cash_counter_footer.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cash_counter_view.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/extra_info_form.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashCounterScreen extends StatefulWidget {
  const CashCounterScreen({Key? key}) : super(key: key);

  @override
  State<CashCounterScreen> createState() => _CashCounterScreenState();
}

class _CashCounterScreenState extends State<CashCounterScreen> {
  late CashCounterCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<CashCounterCubit>(context);
    _cubit.fetchCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(AppStrings.cashCounter),
      ),
      body: BlocListener<CashCounterCubit, CashCounterState>(
        listener: (context, state) {
          if (state is TransactionAddedSuccessfully) {
            ScaffoldMessenger.of(context).showToast(
                "Transaction added successfully!!!", ToastType.success);
          }
          if (state is TransactionFailed) {
            ScaffoldMessenger.of(context)
                .showToast("Failed to add transaction !!!", ToastType.error);
          }
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CashCounterView(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(
                          thickness: 3,
                          color: AppColors.primaryDarkest,
                        ),
                      ),
                      const ExtraInfoForm(),
                      Container(
                        height: 330,
                      )
                    ],
                  ),
                ),
              ),
              const Positioned(
                  bottom: 0, left: 0, right: 0, child: CCBottomSheet())
            ],
          ),
        ),
      ),
    ));
  }
}
