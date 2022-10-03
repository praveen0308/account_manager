part of 'add_transaction_cubit.dart';

@immutable
abstract class AddTransactionState {}

class AddTransactionInitial extends AddTransactionState {}
class AddingTransaction extends AddTransactionState {}
class AddedSuccessfully extends AddTransactionState {
  final PersonModel result;

  AddedSuccessfully(this.result);

}
class Failed extends AddTransactionState {}
