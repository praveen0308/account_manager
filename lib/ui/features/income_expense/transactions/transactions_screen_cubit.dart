import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../models/income_expense/income_expense_model.dart';
import '../../../../repository/income_expense_repository.dart';

part 'transactions_screen_state.dart';

class TransactionsScreenCubit extends Cubit<TransactionsScreenState> {
  final IncomeExpenseRepository _incomeExpenseRepository;
  TransactionsScreenCubit(this._incomeExpenseRepository) : super(TransactionsScreenInitial());


  Future<void> fetchTransactions() async {
    emit(Loading());
    try{

      var result = await _incomeExpenseRepository.getAllTransactions();

      if(result.isNotEmpty){

        emit(ReceivedTransactions(result));
      }else{
        emit(NoTransactions());
      }


    }on Exception catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }

  }
}
