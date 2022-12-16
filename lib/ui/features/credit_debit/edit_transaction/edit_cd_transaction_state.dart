part of 'edit_cd_transaction_cubit.dart';

@immutable
abstract class EditCdTransactionState {}

class EditCdTransactionInitial extends EditCdTransactionState {}
class Error extends EditCdTransactionState {
  final String msg;

  Error(this.msg);

}
class Updating extends EditCdTransactionState {}
class UpdatedSuccessfully extends EditCdTransactionState {}
