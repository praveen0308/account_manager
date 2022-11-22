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

  Future<void> fetchTransactions({int? from,int? to}) async {
    emit(LoadingTransactions());
    try {
      List<CDTransaction> result;
      if(from == null){
        result = await _creditDebitRepository.getTransactionsByPersonId(personModel.personId!);
      }else{
        result = await _creditDebitRepository.getTransactionsByPersonIdAcDate(personModel.personId!,from, to!);

      }

      transactions.clear();

      if (result.isNotEmpty) {
        transactions.addAll(result);
        for (int i = 0; i < transactions.length; i++) {
          if (i == 0) {
            transactions[0].closingBalance =
                transactions[0].credit - transactions[0].debit;
          } else {
            transactions[i].closingBalance =
                transactions[i - 1].closingBalance +
                    transactions[i].credit -
                    transactions[i].debit;
          }
        }
      }

      emit(ReceivedTransactions(result));
    } catch (e) {
      emit(Failed("Something went wrong !!!"));
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTransaction(CDTransaction transaction) async {
    emit(LoadingTransactions());
    try {
      var result =
          await _creditDebitRepository.deleteCDTransaction(personModel,transaction);
      personModel = result;
      emit(DeletedSuccessfully());

    } catch (e) {
      emit(Failed("Something went wrong !!!"));
      debugPrint(e.toString());
    }
  }
}
