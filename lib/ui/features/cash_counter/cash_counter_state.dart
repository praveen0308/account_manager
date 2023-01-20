part of 'cash_counter_cubit.dart';

@immutable
abstract class CashCounterState {
  final int noOfNotes;
  final double denominationTotal;
  final double grandTotal;

  const CashCounterState(this.noOfNotes, this.denominationTotal, this.grandTotal);

  String getGrandTotalInWords(){
    /*String inWords = NumberToWordsEnglish.convert(grandTotal.toInt());
    inWords = inWords.replaceAll("-", " ");
    inWords = inWords.capitalize();*/
    String inWords = CurrencyUtils.convert(grandTotal.toInt());
    inWords = inWords.capitalize();

    return inWords;
  }

}

class CashCounterInitial extends CashCounterState {
  const CashCounterInitial(super.noOfNotes, super.denominationTotal, super.grandTotal);
}
class Loading extends CashCounterState {
  const Loading(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

class AddingTransaction extends CashCounterState {
  const AddingTransaction(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

class EntriesChanged extends CashCounterState {
  const EntriesChanged(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

class ClearScreen extends CashCounterState {
  const ClearScreen(super.noOfNotes, super.denominationTotal, super.grandTotal);
}
class ReceivedCurrencies extends CashCounterState {
  final List<Currency> currencies;

  const ReceivedCurrencies(this.currencies) : super(0, 0.0, 0.0);
}

class TransactionAddedSuccessfully extends CashCounterState {
  final CashTransactionModel savedTransaction;
  final bool addIntCD;
  const TransactionAddedSuccessfully(super.noOfNotes, super.denominationTotal, super.grandTotal, this.savedTransaction, this.addIntCD);
}

class TransactionFailed extends CashCounterState {
  const TransactionFailed(super.noOfNotes, super.denominationTotal, super.grandTotal);
}

