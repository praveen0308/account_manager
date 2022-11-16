import 'package:account_manager/utils/extension_methods.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

class CashTransactionModel {
  static const String table = "cash_transactions";

  static const String columnTransactionId = "transaction_id";
  static const String columnManuallyAdded = "added";
  static const String columnManuallySubtracted = "subtracted";
  static const String columnDenominationTotal = "denomination_total";
  static const String columnGrandTotal = "grand_total";
  static const String columnNoOfNotes = "notes";

  static const String columnTransactionDescription = "description";

  static const String columnName = "name";
  static const String columnMobileNumber = "mobile_number";
  static const String columnAccountNumber = "account_number";
  static const String columnRemark = "remark";

  static const String columnAddedOn = "added_on";
  static const String columnUpdatedOn = "updated_on";

  static const String createTable = '''CREATE TABLE $table (
          $columnTransactionId INTEGER primary key AUTOINCREMENT,
          $columnManuallyAdded REAL NULL DEFAULT 0,
          $columnManuallySubtracted REAL NULL DEFAULT 0,
          $columnDenominationTotal REAL NOT NULL,
          $columnGrandTotal REAL NOT NULL,
          $columnNoOfNotes INTEGER NOT NULL,
          $columnTransactionDescription TEXT NOT NULL,
          $columnName TEXT NULL,
          $columnMobileNumber TEXT NULL,
          $columnAccountNumber TEXT NULL,
          $columnRemark TEXT NULL,
          $columnAddedOn INTEGER NOT NULL,
          $columnUpdatedOn INTEGER NULL
  )''';

  int? transactionID;
  double? manuallyAdded;
  double? manuallySubtracted;
  double denominationTotal;
  double grandTotal;
  int noOfNotes;
  String description;
  String? name;
  String? mobileNumber;
  String? accountNumber;
  String? remark;
  int addedOn;
  int? updatedOn;

  CashTransactionModel(
      {this.transactionID,
      this.manuallyAdded,
      this.manuallySubtracted,
      this.denominationTotal = 0.0,
      this.grandTotal = 0.0,
      this.noOfNotes = 0,
      this.description = "",
      this.name,
      this.mobileNumber,
      this.accountNumber,
      this.remark,
      this.addedOn = 0,
      this.updatedOn});

  // extension methods
  String getTiming() => DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(addedOn));

  String getDate() => DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(addedOn));
  String getFDate() => DateFormat('dd/MM/yy').format(DateTime.fromMillisecondsSinceEpoch(addedOn));

  String getDescription(){
    final Map<int, int> map = getDescriptionMap();
    String result = "";

    map.forEach((key, value) {
      result += "$key x $value = ${key*value}\n";
    });


    return result;
  }

  Map<int, int> getDescriptionMap() {
    final Map<int, int> map = {};
    List<String> items = description.split(",");

    for (String item in items) {
      List<String> element = item.split("x");
      map[int.parse(element[0])] = int.parse(element[1]);
    }
    return map;
  }

  String getFullDescription() {
    final Map<int, int> map = getDescriptionMap();
    String result = "";
    if(name != null){
      if(name!.isNotEmpty){
        result = "Name : $name\n";
      }
    }

    result +=getDescription();
    result += '--'*15;
    result += "\n";
    result += "D. Total : ₹$denominationTotal\n";
    result += "Added(+) : ₹$manuallyAdded\n";
    result += "Subtracted(-) : ₹$manuallySubtracted\n";
    result += '='*20;
    result += "\n";
    result += "Grand Total : ₹$grandTotal";
    result += "\n\n";
    result +=getGrandTotalInWords();
    result += "\n\n";
    result += "[Total $noOfNotes Notes]\n";


    if(remark != null){
      if(remark!.isNotEmpty){
        result += "Remark : $remark\n";
      }
    }


    return result;
  }
  String getGrandTotalInWords(){
    String inWords = NumberToWordsEnglish.convert(grandTotal.toInt());
    inWords = inWords.replaceAll("-", " ");
    inWords = inWords.capitalize();

    return inWords;
  }
  Map<String, dynamic> toMap() {
    return {
      columnTransactionId: transactionID,
      columnManuallyAdded: manuallyAdded,
      columnManuallySubtracted: manuallySubtracted,
      columnDenominationTotal: denominationTotal,
      columnGrandTotal: grandTotal,
      columnNoOfNotes: noOfNotes,
      columnTransactionDescription: description,
      columnName: name,
      columnMobileNumber: mobileNumber,
      columnAccountNumber: accountNumber,
      columnRemark: remark,
      columnAddedOn: addedOn,
      columnUpdatedOn: updatedOn,
    };
  }

  factory CashTransactionModel.fromMap(Map<String, dynamic> map) {
    return CashTransactionModel(
      transactionID: map[columnTransactionId] as int?,
      manuallyAdded: map[columnManuallyAdded] as double?,
      manuallySubtracted: map[columnManuallySubtracted] as double?,
      denominationTotal: map[columnDenominationTotal] as double,
      grandTotal: map[columnGrandTotal] as double,
      noOfNotes: map[columnNoOfNotes] as int,
      description: map[columnTransactionDescription] as String,
      name: map[columnName] as String?,
      mobileNumber: map[columnMobileNumber] as String?,
      accountNumber: map[columnAccountNumber] as String?,
      remark: map[columnRemark] as String?,
      addedOn: map[columnAddedOn] as int,
      updatedOn: map[columnUpdatedOn] as int?,
    );
  }
}
