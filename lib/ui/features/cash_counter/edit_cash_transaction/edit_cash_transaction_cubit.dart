import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../models/cash_transaction.dart';
import '../../../../models/currency.dart';
import '../../../../repository/cash_transaction_repository.dart';

part 'edit_cash_transaction_state.dart';

class EditCashTransactionCubit extends Cubit<EditCashTransactionState> {
  final CashTransactionRepository _cashTransactionRepository;

  EditCashTransactionCubit(this._cashTransactionRepository) : super(EditCashTransactionInitial());

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
    emit(EntriesUpdated(noOfNotes, denominationTotal, grandTotal));
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
    emit(EntriesUpdated(noOfNotes, denominationTotal, grandTotal));
  }

  void updateManuallySubtractedAmt(String amt) {
    manuallySubtracted = double.parse(amt);
    grandTotal = denominationTotal + manuallyAdded - manuallySubtracted;
    emit(EntriesUpdated(noOfNotes, denominationTotal, grandTotal));
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


  }
  void updateCashTransaction(int transactionId) async {
    emit(Updating());

    CashTransactionModel cashTransactionModel = CashTransactionModel();
    cashTransactionModel.transactionID = transactionId;
    cashTransactionModel.manuallySubtracted = manuallySubtracted;
    cashTransactionModel.manuallyAdded = manuallyAdded;
    cashTransactionModel.denominationTotal = denominationTotal;
    cashTransactionModel.grandTotal = grandTotal;
    cashTransactionModel.noOfNotes = noOfNotes;
    cashTransactionModel.name = personName;
    cashTransactionModel.remark = remark;
    cashTransactionModel.description = getFormattedDescription();
    cashTransactionModel.updatedOn = DateTime.now().millisecondsSinceEpoch;
    cashTransactionModel.addedOn = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute).millisecondsSinceEpoch;
    try{
      var result = await _cashTransactionRepository
          .updateCashTransaction(cashTransactionModel);


        emit(UpdatedSuccessfully());
        clearFields();

    }catch(e){
      emit(Error("Something went wrong!!!"));
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
