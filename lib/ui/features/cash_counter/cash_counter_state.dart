part of 'cash_counter_cubit.dart';

@immutable
abstract class CashCounterState {
  final int noOfNotes;
  final double denominationTotal;
  final double grandTotal;

  CashCounterState(this.noOfNotes, this.denominationTotal, this.grandTotal);

}

class CashCounterInitial extends CashCounterState {
  CashCounterInitial(super.noOfNotes, super.denominationTotal, super.grandTotal);
}
class Loading extends CashCounterState {
  Loading(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

class AddingTransaction extends CashCounterState {
  AddingTransaction(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

class EntriesChanged extends CashCounterState {
  EntriesChanged(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

class ClearScreen extends CashCounterState {
  final List<Currency> currencies;
  ClearScreen(super.noOfNotes, super.denominationTotal, super.grandTotal, this.currencies);
}
class ReceivedCurrencies extends CashCounterState {
  final List<Currency> currencies;

  ReceivedCurrencies(this.currencies) : super(0, 0.0, 0.0);
}

class TransactionAddedSuccessfully extends CashCounterState {
  TransactionAddedSuccessfully(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

class TransactionFailed extends CashCounterState {
  TransactionFailed(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

