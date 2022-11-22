part of 'transactions_screen_cubit.dart';

@immutable
abstract class TransactionsScreenState {}

class TransactionsScreenInitial extends TransactionsScreenState {}

class Loading extends TransactionsScreenState {}

class NoTransactions extends TransactionsScreenState {}

class Failed extends TransactionsScreenState {}

class Error extends TransactionsScreenState {
  final String msg;

  Error(this.msg);
}

class ReceivedTransactions extends TransactionsScreenState {
  final List<IncomeExpenseModel> transactions;

  ReceivedTransactions(this.transactions);
}
