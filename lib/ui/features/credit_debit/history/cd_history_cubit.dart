import 'package:account_manager/models/person_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../models/credit_debit_transaction.dart';
import '../../../../repository/credit_debit_repository.dart';

part 'cd_history_state.dart';

class CdHistoryCubit extends Cubit<CdHistoryState> {
  final CreditDebitRepository _creditDebitRepository;
  CdHistoryCubit(this._creditDebitRepository) : super(CdHistoryInitial());

  final List<CDTransaction> transactions = [];
  late PersonModel personModel;
  Future<void> fetchTransactions() async {
    emit(LoadingTransactions());
    try{
      var result = await _creditDebitRepository.getTransactionsByPersonId(personModel.personId!);
      transactions.clear();
      transactions.addAll(result);
      emit(ReceivedTransactions(result));
    }catch(e){
      emit(Failed("Something went wrong !!!"));
      debugPrint(e.toString());
    }

  }
  Future<void> deleteTransaction(int transactionId) async {
    emit(LoadingTransactions());
    try{
      var result = await _creditDebitRepository.deleteCDTransaction(transactionId);
      emit(DeletedSuccessfully());
    }catch(e){
      emit(Failed("Something went wrong !!!"));
      debugPrint(e.toString());
    }

  }

}
