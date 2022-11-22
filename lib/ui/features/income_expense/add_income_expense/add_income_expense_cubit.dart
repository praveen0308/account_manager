import 'package:account_manager/models/income_expense/income_expense_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../repository/income_expense_repository.dart';

part 'add_income_expense_state.dart';

class AddIncomeExpenseCubit extends Cubit<AddIncomeExpenseState> {
  final IncomeExpenseRepository _incomeExpenseRepository;
  AddIncomeExpenseCubit(this._incomeExpenseRepository) : super(AddIncomeExpenseInitial());

  Future<void> addIncomeExpense(IncomeExpenseModel model) async {
    emit(Loading());
    try{

      var result = await _incomeExpenseRepository.addIncomeExpense(model);
      if(result){
        emit(AddedSuccessfully());
      }else{
        emit(Failed());
      }


    }catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }

  }
}
