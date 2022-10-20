import 'package:intl/intl.dart';

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
  String getDate() => DateFormat.yMMMd().format(DateTime.parse(date));

  String getDescription(){
    final Map<int, int> map = notes;
    String result = "";

    map.forEach((key, value) {
      result = "${key}x$value=${key*value}\n";
    });


    return result;
  }


  String getFullDescription() {
    final Map<int, int> map = notes;
    String result = "";

    result = "Date : $date\n";

    result +=getDescription();

    result += "D. Total : ₹$denominationTotal\n";
    result += "Added(+) : ₹$manuallyAdded\n";
    result += "Subtracted(-) : ₹$manuallySubtracted\n";


    return result;
  }

}