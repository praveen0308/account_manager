import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../repository/income_expense_repository.dart';

part 'spending_screen_state.dart';

class SpendingScreenCubit extends Cubit<SpendingScreenState> {
  final IncomeExpenseRepository _incomeExpenseRepository;
  SpendingScreenCubit(this._incomeExpenseRepository) : super(SpendingScreenInitial());
}
