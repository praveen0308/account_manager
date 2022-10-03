import 'package:intl/intl.dart';

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
          $columnAddedOn TEXT NOT NULL,
          $columnUpdatedOn TEXT NULL
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
  String addedOn;
  String? updatedOn;

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
      this.addedOn = "",
      this.updatedOn});

  // extension methods
  String getTiming() => DateFormat.jm().format(DateTime.parse(addedOn));

  String getDate() => DateFormat.yMd().format(DateTime.parse(addedOn));

  String getDescription(){
    final Map<int, int> map = getDescriptionMap();
    String result = "";

    map.forEach((key, value) {
      result = "${key}x$value=${key*value}\n";
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

    result += "D. Total : ₹$denominationTotal\n";
    result += "Added(+) : ₹$manuallyAdded\n";
    result += "Subtracted(-) : ₹$manuallySubtracted\n";


    if(remark != null){
      if(remark!.isNotEmpty){
        result = "Remark : $remark\n";
      }
    }


    return result;
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
      addedOn: map[columnAddedOn] as String,
      updatedOn: map[columnUpdatedOn] as String?,
    );
  }
}
