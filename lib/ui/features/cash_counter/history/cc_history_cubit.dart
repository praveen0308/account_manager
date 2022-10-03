import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../models/cash_transaction.dart';
import '../../../../repository/cash_transaction_repository.dart';

part 'cc_history_state.dart';

class CcHistoryCubit extends Cubit<CcHistoryState> {
  final CashTransactionRepository _cashTransactionRepository;
  CcHistoryCubit(this._cashTransactionRepository) : super(CcHistoryInitial());

  double grandTotal = 0.0;
  final List<CashTransactionModel> transactions = [];

  Future<void> fetchTransactions() async {
    emit(LoadingData());
    try{
      var result = await _cashTransactionRepository.fetchAllTransactions();
      grandTotal = 0;

      transactions.clear();
      transactions.addAll(result);
      transactions.forEach((element) {
        grandTotal+=element.grandTotal;
      });

      emit(ReceivedHistory(result,grandTotal));
    }catch(e){
      debugPrint(e.toString());
    }

  }
}
