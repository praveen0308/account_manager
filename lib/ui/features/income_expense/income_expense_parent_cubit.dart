import 'package:account_manager/utils/date_time_helper.dart';
import 'package:account_manager/utils/income_type.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import "package:collection/collection.dart";
import '../../../models/income_expense/income_expense_model.dart';
import '../../../repository/income_expense_repository.dart';

part 'income_expense_parent_state.dart';

class IncomeExpenseParentCubit extends Cubit<IncomeExpenseParentState> {
  final IncomeExpenseRepository _incomeExpenseRepository;
  IncomeExpenseParentCubit(this._incomeExpenseRepository) : super(IncomeExpenseParentInitial());

  List<IncomeExpenseModel> transactions = [];
  num income = 0;
  num expense = 0;

  Future<void> fetchTransactions(DateTime date,DateFilter filter) async {
    emit(Loading());
    try{
      int start=0,end =0;
      switch(filter){
        case DateFilter.daily:
          start = date.firstMillisecondOfDay;
          end = date.lastMillisecondOfDay;
          break;
        case DateFilter.monthly:
          start = date.firstMillisecondOfMonth;
          end = date.lastMillisecondOfMonth;
          break;
        case DateFilter.yearly:
          start = date.firstMillisecondOfYear;
          end = date.lastMillisecondOfYear;
          break;
      }
      var result = await _incomeExpenseRepository.getTransactionsAcDate(start,end);
      transactions.clear();
      transactions.addAll(result);
      income =0;
      expense=0;
      Map<String,num> incomeCats = {};
      Map<String,num> expenseCats = {};
      for (var t in transactions) {
        if(t.type == IncomeType.income.name){
          income +=t.amount;
          if(incomeCats.containsKey(t.categoryName)){
            incomeCats.update(t.categoryName.toString(), (value) => incomeCats[t.categoryName]!+t.amount);
          }else{
            incomeCats[t.categoryName!] = t.amount;
          }

        }else{
          expense +=t.amount;

          if(expenseCats.containsKey(t.categoryName)){
            expenseCats.update(t.categoryName.toString(), (value) => expenseCats[t.categoryName]!+t.amount);
          }else{
            expenseCats[t.categoryName!] = t.amount;
          }
        }
      }

      emit(ReceivedSummary(income,expense,incomeCats,expenseCats));

    }on Exception catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }

  }


}
