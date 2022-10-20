import 'dart:async';

import 'package:account_manager/models/currency.dart';
import 'package:account_manager/repository/currency_repository.dart';
import 'package:account_manager/ui/features/cash_counter/cash_counter_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'cash_calculator_view_state.dart';

class CashCalculatorViewCubit extends Cubit<CashCalculatorViewState> {
  final CurrencyRepository _currencyRepository;
  final CashCounterCubit _cashCounterCubit;
  late StreamSubscription streamSubscription;
  CashCalculatorViewCubit(this._currencyRepository, this._cashCounterCubit) : super(CashCalculatorViewInitial()){
    streamSubscription=_cashCounterCubit.stream.listen((state) async {
      if(state is ClearScreen){

        debugPrint("Clear screen fired in $this");
        emit(Clear());
        await Future.delayed(const Duration(milliseconds: 100));
        emit(ReceivedCurrencies(currencies));
      }
    });

  }




  List<Currency> currencies = [];
  Future<void> fetchCurrencies() async {
    emit(Loading());
    try{
      var result = await _currencyRepository.getActiveCurrencies();
      currencies.clear();
      currencies.addAll(result);
      emit(ReceivedCurrencies(result));
    }catch(e){
      debugPrint(e.toString());
    }

  }
}
