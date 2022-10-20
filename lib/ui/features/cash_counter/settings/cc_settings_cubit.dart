import 'package:account_manager/repository/currency_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../models/currency.dart';

part 'cc_settings_state.dart';

class CcSettingsCubit extends Cubit<CcSettingsState> {
  final CurrencyRepository _currencyRepository;
  CcSettingsCubit(this._currencyRepository) : super(CcSettingsInitial());

  List<Currency> currencies = [];
  Future<void> fetchCurrencies() async {
    emit(Loading());
    try{
      var result = await _currencyRepository.getAllCurrencies();
      currencies.clear();
      currencies.addAll(result);
      emit(ReceivedNotes(result));
    }catch(e){
      emit(Error());
      debugPrint(e.toString());
    }
  }

  Future<void> updateCurrencies() async {
    emit(Loading());
    try{
      var result = await _currencyRepository.updateCurrencies(currencies);

      emit(UpdatedSuccessfully());
    }catch(e){
      emit(Error());
      debugPrint(e.toString());
    }
  }

}
