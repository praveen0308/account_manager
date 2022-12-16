part of 'edit_income_expense_cubit.dart';

@immutable
abstract class EditIncomeExpenseState {}

class EditIncomeExpenseInitial extends EditIncomeExpenseState {}
class Updating extends EditIncomeExpenseState {}
class Deleting extends EditIncomeExpenseState {}
class UpdatedSuccessfully extends EditIncomeExpenseState {}
class DeletedSuccessfully extends EditIncomeExpenseState {}
class Error extends EditIncomeExpenseState {
  final String msg;

  Error(this.msg);
}
