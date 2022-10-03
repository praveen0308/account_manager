import 'package:account_manager/models/currency.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/widgets/cash_counting_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashCounterView extends StatefulWidget {
  const CashCounterView({Key? key}) : super(key: key);

  @override
  State<CashCounterView> createState() => _CashCounterViewState();
}

class _CashCounterViewState extends State<CashCounterView> {
  final List<Currency> _currencies = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CashCounterCubit, CashCounterState>(
      listener: (context, state) {
        if (state is ReceivedCurrencies) {
          _currencies.clear();
          _currencies.addAll(state.currencies);
        }
        if (state is ClearScreen) {
          _currencies.clear();
          _currencies.addAll(state.currencies);
        }

      },
      buildWhen: (previousState, newState) {
        if (newState is Loading) {
          return true;
        }
        if (newState is ReceivedCurrencies) {
          return true;
        }
        if (newState is ClearScreen) {
          return true;
        }

        return false;
      },
      builder: (context, state) {
        if (state is Loading) const CircularProgressIndicator();

        return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var currency = _currencies[index];
              return CashCountingRow(
                item: currency.item,
                qty: currency.qty!,
                onQtyChanged: (int item, int qty) {
                  BlocProvider.of<CashCounterCubit>(context)
                      .updateNoteQty(item, qty);

                },
              );
            },
            separatorBuilder: (_, index) {
              return const Divider(
                thickness: 2,
              );
            },
            itemCount: _currencies.length);
      },
    );
  }
}
