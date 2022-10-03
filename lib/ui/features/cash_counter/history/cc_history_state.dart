part of 'cc_history_cubit.dart';

@immutable
abstract class CcHistoryState {}

class CcHistoryInitial extends CcHistoryState {}
class LoadingData extends CcHistoryState {}
class ReceivedHistory extends CcHistoryState {
  final double grandTotal;
  final List<CashTransactionModel> data;

  ReceivedHistory(this.data, this.grandTotal);
}
