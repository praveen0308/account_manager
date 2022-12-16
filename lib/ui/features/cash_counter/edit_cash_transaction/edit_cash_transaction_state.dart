part of 'edit_cash_transaction_cubit.dart';

@immutable
abstract class EditCashTransactionState {}

class EditCashTransactionInitial extends EditCashTransactionState {}
class EntriesUpdated extends EditCashTransactionState {
  final int noOfNotes;
  final num denominationTotal;
  final num grandTotal;

  EntriesUpdated(this.noOfNotes, this.denominationTotal, this.grandTotal);
}
class Updating extends EditCashTransactionState {}
class Error extends EditCashTransactionState {
  final String msg;

  Error(this.msg);
}
class UpdatedSuccessfully extends EditCashTransactionState {}
