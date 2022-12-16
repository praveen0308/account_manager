import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../models/income_expense/income_expense_model.dart';
import '../../../../repository/income_expense_repository.dart';

part 'edit_income_expense_state.dart';

class EditIncomeExpenseCubit extends Cubit<EditIncomeExpenseState> {
  final IncomeExpenseRepository _incomeExpenseRepository;

  EditIncomeExpenseCubit(this._incomeExpenseRepository)
      : super(EditIncomeExpenseInitial());

  Future<void> updateIncomeExpense(IncomeExpenseModel model) async {
    emit(Updating());
    try {
      await _incomeExpenseRepository.updateIncomeExpense(model);
      emit(UpdatedSuccessfully());
    } catch (e) {
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }
  }
  Future<void> deleteIncomeExpense(int transactionID) async {
    emit(Updating());
    try {
      await _incomeExpenseRepository.deleteIncomeExpense(transactionID);
      emit(UpdatedSuccessfully());
    } catch (e) {
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }
  }
}
