import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../models/currency.dart';
import '../../../repository/currency_repository.dart';

part 'cash_counter_state.dart';

class CashCounterCubit extends Cubit<CashCounterState> {

  final CurrencyRepository _currencyRepository;
  CashCounterCubit(this._currencyRepository) : super(CashCounterInitial(0,0.0,0.0));

  int noOfNotes = 0;
  double denominationTotal = 0;
  double manuallyAdded = 0;
  double manuallySubtracted = 0;
  double grandTotal = 0;
  Map<int,int> noteMaps = Currency.getCurrencyMap();
  String personName = "";
  String remark = "";

  Future<void> fetchCurrencies() async {
    emit(Loading(0,0.0,0.0));
    try{
      var result = await _currencyRepository.getAllCurrencies();
      emit(ReceivedCurrencies(result));
    }catch(e){
      debugPrint(e.toString());
    }

  }
  void updateNoteQty(int item,int newQty){
    noteMaps[item] = newQty;

    noOfNotes = 0;
    denominationTotal = 0;

    noteMaps.forEach((key, value) {
      noOfNotes += value;
      denominationTotal = denominationTotal + key*value;
    });

    grandTotal = denominationTotal + manuallyAdded - manuallySubtracted;

    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    emit(EntriesChanged(noOfNotes, denominationTotal, grandTotal));
  }

  void updateManuallyAddedAmt(String amt){
    manuallyAdded = double.parse(amt);
    grandTotal = denominationTotal + manuallyAdded - manuallySubtracted;
    emit(EntriesChanged(noOfNotes, denominationTotal, grandTotal));
  }
  void updateManuallySubtractedAmt(String amt){
    manuallySubtracted = double.parse(amt);
    grandTotal = denominationTotal + manuallyAdded - manuallySubtracted;
    emit(EntriesChanged(noOfNotes, denominationTotal, grandTotal));
  }
  void clearFields(){

  }
}
