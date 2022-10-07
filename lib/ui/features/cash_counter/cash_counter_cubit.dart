import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/repository/cash_transaction_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../models/currency.dart';
import '../../../repository/currency_repository.dart';

part 'cash_counter_state.dart';

class CashCounterCubit extends Cubit<CashCounterState> {
  final CurrencyRepository _currencyRepository;
  final CashTransactionRepository _cashTransactionRepository;

  CashCounterCubit(this._currencyRepository, this._cashTransactionRepository)
      : super(CashCounterInitial(0, 0.0, 0.0));

  int noOfNotes = 0;
  double denominationTotal = 0;
  double manuallyAdded = 0;
  double manuallySubtracted = 0;
  double grandTotal = 0;
  Map<int, int> noteMaps = Currency.getCurrencyMap();
  String personName = "";
  String remark = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  void updateNoteQty(int item, int newQty) {
    noteMaps[item] = newQty;

    noOfNotes = 0;
    denominationTotal = 0;

    noteMaps.forEach((key, value) {
      noOfNotes += value;
      denominationTotal = denominationTotal + key * value;
    });

    grandTotal = denominationTotal + manuallyAdded - manuallySubtracted;

    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    emit(EntriesChanged(noOfNotes, denominationTotal, grandTotal));
  }

  void setTransactionDate(DateTime dateTime) {
    selectedDate = dateTime;
  }

  void setTransactionTiming(TimeOfDay timeOfDay) {
    selectedTime = timeOfDay;
  }

  void updateManuallyAddedAmt(String amt) {
    manuallyAdded = double.parse(amt);
    grandTotal = denominationTotal + manuallyAdded - manuallySubtracted;
    emit(EntriesChanged(noOfNotes, denominationTotal, grandTotal));
  }

  void updateManuallySubtractedAmt(String amt) {
    manuallySubtracted = double.parse(amt);
    grandTotal = denominationTotal + manuallyAdded - manuallySubtracted;
    emit(EntriesChanged(noOfNotes, denominationTotal, grandTotal));
  }

  void clearFields() {
    noOfNotes = 0;
    manuallyAdded = 0;
    manuallySubtracted = 0;
    grandTotal = 0;
    denominationTotal = 0;
    personName = "";
    remark = "";

    noteMaps.forEach((key, value) {
      noteMaps.update(key, (value) => 0);
    });

    emit(ClearScreen(noOfNotes, denominationTotal, grandTotal));
  }

  void addCashTransaction() async {
    emit(AddingTransaction(noOfNotes, denominationTotal, grandTotal));

    CashTransactionModel cashTransactionModel = CashTransactionModel();
    cashTransactionModel.manuallySubtracted = manuallySubtracted;
    cashTransactionModel.manuallyAdded = manuallyAdded;
    cashTransactionModel.denominationTotal = denominationTotal;
    cashTransactionModel.grandTotal = grandTotal;
    cashTransactionModel.noOfNotes = noOfNotes;
    cashTransactionModel.name = personName;
    cashTransactionModel.remark = remark;
    cashTransactionModel.description = getFormattedDescription();
    cashTransactionModel.addedOn = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute).toString();
    var result = await _cashTransactionRepository
        .addCashTransaction(cashTransactionModel);

    if (result) {
      emit(TransactionAddedSuccessfully(
          noOfNotes, denominationTotal, grandTotal));
      clearFields();
    } else {
      emit(TransactionFailed(noOfNotes, denominationTotal, grandTotal));
    }
  }

  String getFormattedDescription() {
    var output = "";

    noteMaps.forEach((key, value) {
      if (value > 0) {
        output += "${key}x$value,";
      }
    });

    output = output.substring(0, output.length - 1);
    return output;
  }
}
