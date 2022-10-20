part of 'cc_history_cubit.dart';

@immutable
abstract class CcHistoryState {}

class CcHistoryInitial extends CcHistoryState {}
class LoadingData extends CcHistoryState {}
class DeletedSuccessfully extends CcHistoryState {}
class Error extends CcHistoryState {
  final String msg;

  Error(this.msg);
}
class ReceivedHistory extends CcHistoryState {
  final double grandTotal;
  final List<DayTransactionModel> data;

  ReceivedHistory(this.data, this.grandTotal);
}
