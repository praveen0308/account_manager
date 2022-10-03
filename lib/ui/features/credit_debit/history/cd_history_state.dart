part of 'cd_history_cubit.dart';

@immutable
abstract class CdHistoryState {}

class CdHistoryInitial extends CdHistoryState {}
class Failed extends CdHistoryState {
  final String msg;

  Failed(this.msg);
}
class LoadingTransactions extends CdHistoryState {}
class ReceivedTransactions extends CdHistoryState {
  final List<CDTransaction> transactions;
  ReceivedTransactions(this.transactions);
}

