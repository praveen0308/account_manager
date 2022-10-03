part of 'credit_debit_cubit.dart';

@immutable
abstract class CreditDebitState {}

class CreditDebitInitial extends CreditDebitState {}
class LoadingPersons extends CreditDebitState {}
class LoadingStats extends CreditDebitState {}
class Error extends CreditDebitState {
  final String msg;

  Error(this.msg);

}
class ReceivedPersons extends CreditDebitState {
  final List<PersonModel> persons;

  ReceivedPersons(this.persons);

}
class ReceivedStats extends CreditDebitState {
  final double grandTotal;
  final WalletModel wallet1;
  final WalletModel wallet2;

  ReceivedStats(this.grandTotal, this.wallet1, this.wallet2);




}
