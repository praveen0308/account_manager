part of 'income_expense_parent_cubit.dart';

@immutable
abstract class IncomeExpenseParentState {}

class IncomeExpenseParentInitial extends IncomeExpenseParentState {}
class Loading extends IncomeExpenseParentState {}
class Error extends IncomeExpenseParentState {
  final String msg;

  Error(this.msg);
}
class ReceivedSummary extends IncomeExpenseParentState {
  final num income;
  final num expense;

  ReceivedSummary(this.income, this.expense);

}
class FilterChanged extends IncomeExpenseParentState {
  final int start;
  final int end;

  FilterChanged(this.start, this.end);
}
