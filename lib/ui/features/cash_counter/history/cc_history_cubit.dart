import 'package:account_manager/models/day_transaction_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';
import '../../../../models/cash_transaction.dart';
import '../../../../repository/cash_transaction_repository.dart';

part 'cc_history_state.dart';

class CcHistoryCubit extends Cubit<CcHistoryState> {
  final CashTransactionRepository _cashTransactionRepository;

  CcHistoryCubit(this._cashTransactionRepository) : super(CcHistoryInitial());

  // all total
  double grandTotal = 0.0;
  double gDenominationTotal = 0.0;
  double gAdded = 0.0;
  double gSubtracted = 0.0;
  int gNoOfNotes = 0;
  Map<int,int> gNotes = {};
  final List<CashTransactionModel> transactions = [];

  Future<void> fetchTransactions() async {
    emit(LoadingData());
    try {
      var result = await _cashTransactionRepository.fetchAllTransactions();
      grandTotal = 0;

      transactions.clear();
      transactions.addAll(result);
      for (var element in transactions) {
        grandTotal += element.grandTotal;
      }

      var gTransactions = groupBy(
          transactions,
          (CashTransactionModel e) =>
              DateFormat.yMMMd().format(DateTime.parse(e.addedOn)));
      List<DayTransactionModel> dayTransactions = [];

      gTransactions.forEach((date, transactions) {
        var noOfNotes = 0;
        double denominationTotal = 0;
        double mAdded = 0;
        double mSubtracted = 0;
        Map<int, int> notes = {};

        for (var t in transactions) {
          noOfNotes += t.noOfNotes;
          gNoOfNotes +=t.noOfNotes;

          denominationTotal += t.denominationTotal;
          gDenominationTotal += t.denominationTotal;

          mAdded += t.manuallyAdded!;
          gAdded += t.manuallyAdded!;

          mSubtracted += t.manuallySubtracted!;
          gSubtracted += t.manuallySubtracted!;
        }

        for (var t in transactions) {
          t.getDescriptionMap().forEach((key, value) {
            if(notes.containsKey(key)){
              notes.update(key, (v) => v+value);
            }else{
              notes[key] = value;
            }

            // global entries
            if(gNotes.containsKey(key)){
              gNotes.update(key, (v) => v+value);
            }else{
              gNotes[key] = value;
            }
          });
        }

        var dayTransaction = DayTransactionModel(date, transactions, grandTotal,
            notes, noOfNotes, denominationTotal, mAdded, mSubtracted);
        dayTransactions.add(dayTransaction);
      });

      emit(ReceivedHistory(dayTransactions, grandTotal));
    } catch (e) {
      emit(Error("Something went wrong !!!"));
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    emit(LoadingData());
    try{
      await _cashTransactionRepository.deleteTransaction(transactionId);

      emit(DeletedSuccessfully());
    }catch(e){
      emit(Error("Something went wrong !!!"));
      debugPrint(e.toString());
    }
  }
}
