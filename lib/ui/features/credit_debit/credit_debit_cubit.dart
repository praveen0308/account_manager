import 'package:account_manager/models/wallet_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../models/person_model.dart';
import '../../../repository/credit_debit_repository.dart';

part 'credit_debit_state.dart';

class CreditDebitCubit extends Cubit<CreditDebitState> {
  final CreditDebitRepository _creditDebitRepository;
  CreditDebitCubit(this._creditDebitRepository) : super(CreditDebitInitial());

  final List<PersonModel> persons = [];

  Future<void> fetchPersons() async {
    emit(LoadingPersons());
    try{
      var result = await _creditDebitRepository.getAllPersons();
      persons.clear();
      persons.addAll(result);
      emit(ReceivedPersons(result));

    }catch(e){
      debugPrint(e.toString());
    }

  }

  Future<void> fetchStats() async {
    emit(LoadingStats());
    try{
      var result = await _creditDebitRepository.fetchStats();
      var wallet1 = result[0];
      var wallet2 = result[1];
      var grandTotal = wallet1.credit+wallet2.credit-wallet1.debit-wallet2.debit;
      emit(ReceivedStats(grandTotal, wallet1, wallet2));
    }catch(e){
      debugPrint(e.toString());

    }

  }

}
