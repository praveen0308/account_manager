part of 'add_income_expense_cubit.dart';

@immutable
abstract class AddIncomeExpenseState {}

class AddIncomeExpenseInitial extends AddIncomeExpenseState {}
class Loading extends AddIncomeExpenseState {}
class AddedSuccessfully extends AddIncomeExpenseState {}
class Failed extends AddIncomeExpenseState {}
class Error extends AddIncomeExpenseState {
  final String msg;

  Error(this.msg);
}


