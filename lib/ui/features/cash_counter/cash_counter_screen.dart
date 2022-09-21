import 'package:account_manager/models/currency.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/bottom_sheet.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cash_counting_row.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/extra_info_form.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/container_light.dart';
import 'package:account_manager/widgets/date_picker_widget.dart';
import 'package:account_manager/widgets/outlined_container.dart';
import 'package:account_manager/widgets/outlined_text_field.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:account_manager/widgets/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashCounterScreen extends StatefulWidget {
  const CashCounterScreen({Key? key}) : super(key: key);

  @override
  State<CashCounterScreen> createState() => _CashCounterScreenState();
}

class _CashCounterScreenState extends State<CashCounterScreen> {
  late CashCounterCubit _cubit;
  List<Currency> _currencies = [];

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
            resizeToAvoidBottomInset:false,
      appBar: AppBar(
        title: const Text(AppStrings.cashCounter),
      ),
      body: BlocConsumer<CashCounterCubit, CashCounterState>(
        listener: (context, state) {
          if (state is ReceivedCurrencies){
            setState((){
              _currencies.clear();
              _currencies.addAll(state.currencies);
            });
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is Loading) const CircularProgressIndicator(),


                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                var currency = _currencies[index];
                                return CashCountingRow(
                                  item: currency.item,
                                  qty: 0,
                                  onQtyChanged: (int item, int qty) {
                                    _cubit.updateNoteQty(item, qty);
                                  },
                                );
                              },
                              separatorBuilder: (_, index) {
                                return const Divider(
                                  thickness: 2,
                                );
                              },
                              itemCount: _currencies.length),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: const Divider(
                            thickness: 3,
                            color: AppColors.primaryDarkest,
                          ),
                        ),
                        ExtraInfoForm(),
                        Container(
                          height: 330,
                        )
                      ],
                    ),
                  ),
                ),
                const Positioned(bottom: 0, left: 0, right: 0, child: CCBottomSheet())
              ],
            ),
          );
        },
      ),
    ));
  }
}
