import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_income_expense_state.dart';

class AddIncomeExpenseCubit extends Cubit<AddIncomeExpenseState> {
  AddIncomeExpenseCubit() : super(AddIncomeExpenseInitial());
}
