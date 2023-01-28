import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../models/credit_debit_transaction.dart';

part 'business_report_state.dart';

class BusinessReportCubit extends Cubit<BusinessReportState> {
  final CreditDebitRepository _creditDebitRepository;
  BusinessReportCubit(this._creditDebitRepository) : super(BusinessReportInitial());

  num totalCredit = 0;
  num totalDebit = 0;
  String activeTypeFilter = "All";
  final List<CDTransaction> transactions = [];
  void filterTransactions(String? filter){
    if(filter!=null){
      activeTypeFilter = filter;
    }
    emit(Loading());
    List<CDTransaction> fTransactions = [];
    if(activeTypeFilter=="Credit"){
      fTransactions =  transactions.where((element) => element.type=="credit").toList();
    }
    else if(activeTypeFilter=="Debit"){
      fTransactions =  transactions.where((element) => element.type=="debit").toList();
    }else{
      fTransactions.addAll(transactions);

    }
    totalDebit = 0;
    totalCredit = 0;
    if(fTransactions.isNotEmpty){
      fTransactions.forEach((element) {
        totalDebit += element.debit;
        totalCredit += element.credit;
      });
      emit(ReceivedTransactions(fTransactions));
    }else{
      totalCredit = 0;
      totalDebit = 0;
      emit(NoTransactions());
    }

  }
  Future<void> fetchTransactions(int walletId,DateTime from,DateTime to) async {
    emit(Loading());
    try {
      List<CDTransaction> result;
      result = await _creditDebitRepository.getTransactionsByWalletIdAcDate(walletId,from.millisecondsSinceEpoch, to.millisecondsSinceEpoch);
      transactions.clear();

      if (result.isNotEmpty) {
        transactions.addAll(result);
        transactions.removeWhere((element) => element.isCancel==true);
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
      transactions.forEach((element) {
        debugPrint(element.toString());
      });


      filterTransactions(null);
    } catch (e) {
      emit(Error("Something went wrong !!!"));
      debugPrint(e.toString());
    }
  }
}
