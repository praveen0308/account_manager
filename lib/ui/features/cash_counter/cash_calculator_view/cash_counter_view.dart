import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cash_calculator_view_cubit.dart';
import 'cash_counting_row.dart';

class CashCounterView extends StatefulWidget {
  final Function(int item, int qty) onQtyChanged;

  const CashCounterView({Key? key, required this.onQtyChanged})
      : super(key: key);

  @override
  State<CashCounterView> createState() => _CashCounterViewState();
}

class _CashCounterViewState extends State<CashCounterView> {


  @override
  void initState() {
    BlocProvider.of<CashCalculatorViewCubit>(context).fetchCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCalculatorViewCubit, CashCalculatorViewState>(
      builder: (context, state) {
        if (state is Loading) {
          return const CircularProgressIndicator();
        }else if(state is Clear){
          return Container();

        } else if (state is ReceivedCurrencies) {

          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var currency = state.currencies[index];
                return CashCountingRow(
                  onQtyChanged: (int item, int qty) {
                    // BlocProvider.of<CashCalculatorViewCubit>(context)
                    //     .updateNoteQty(item, qty);
                    widget.onQtyChanged(item, qty);
                  },
                  qty: 0,
                  item: currency.item,
                );
              },
              separatorBuilder: (_, index) {
                return const Divider(
                  thickness: 2,
                );
              },
              itemCount: state.currencies.length);
        } else {
          return const Center(child: Text("ERROR :X"));
        }
      },
    );
  }
}
