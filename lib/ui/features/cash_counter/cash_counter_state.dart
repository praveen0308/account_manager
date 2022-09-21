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

class EntriesChanged extends CashCounterState {
  EntriesChanged(super.noOfNotes, super.denominationTotal, super.grandTotal);
}
class ReceivedCurrencies extends CashCounterState {
  final List<Currency> currencies;

  ReceivedCurrencies(this.currencies) : super(0, 0.0, 0.0);

}

