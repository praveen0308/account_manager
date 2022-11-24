import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../models/income_expense/income_expense_model.dart';
import '../../../../repository/income_expense_repository.dart';
import '../../../../utils/date_time_helper.dart';
import '../../../../utils/income_type.dart';

part 'transactions_screen_state.dart';

class TransactionsScreenCubit extends Cubit<TransactionsScreenState> {
  final IncomeExpenseRepository _incomeExpenseRepository;

  TransactionsScreenCubit(this._incomeExpenseRepository)
      : super(TransactionsScreenInitial());

  List<IncomeExpenseModel> transactions = [];
  num income = 0;
  num expense = 0;

  Future<void> fetchTransactions(DateTime date, DateFilter filter) async {
    emit(Loading());
    try {
      int start = 0, end = 0;
      switch (filter) {
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
      var result =
          await _incomeExpenseRepository.getTransactionsAcDate(start, end);
      transactions.clear();
      transactions.addAll(result);
      income = 0;
      expense = 0;
      for (var t in transactions) {
        if (t.type == IncomeType.income.name) {
          income += t.amount;
        } else {
          expense += t.amount;
        }
      }

      if (result.isNotEmpty) {
        emit(ReceivedTransactions(result));
      } else {
        emit(NoTransactions());
      }
    } on Exception catch (e) {
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }
  }

  void applyFilter(String typeFilter, String otherFilter) {
    List<IncomeExpenseModel> result = [];

    if (typeFilter == "Income") {
      for (var value in transactions) {
        if (value.type == IncomeType.income.name) {
          result.add(value);
        }
      }
    } else if (typeFilter == "Expense") {
      for (var value in transactions) {
        if (value.type == IncomeType.expense.name) {
          result.add(value);
        }
      }
    } else {
      for (var value in transactions) {
        result.add(value);
      }
    }

    switch (otherFilter) {
      case "Newest to Old":
        result.sort((a, b) => a.date.compareTo(b.date));
        break;
      case "Oldest to New":
        result.sort((b, a) => a.date.compareTo(b.date));
        break;
      case "Low to High":
        result.sort((a, b) => a.amount.compareTo(b.amount));
        break;
      case "High to Low":
        result.sort((b, a) => a.amount.compareTo(b.amount));
        break;
    }

    income = 0;
    expense = 0;
    for (var t in result) {
      if (t.type == IncomeType.income.name) {
        income += t.amount;
      } else {
        expense += t.amount;
      }
    }

    if (result.isNotEmpty) {
      emit(ReceivedTransactions(result));
    } else {
      emit(NoTransactions());
    }
  }
}
