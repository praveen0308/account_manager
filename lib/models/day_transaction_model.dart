import 'cash_transaction.dart';

class DayTransactionModel{
  String date;
  List<CashTransactionModel> cashTransactions;
  double grandTotal;
  Map<int,int> notes;
  int noOfNotes;
  double denominationTotal;
  double manuallyAdded;
  double manuallySubtracted;

  DayTransactionModel(
      this.date,
      this.cashTransactions,
      this.grandTotal,
      this.notes,
      this.noOfNotes,
      this.denominationTotal,
      this.manuallyAdded,
      this.manuallySubtracted);
}