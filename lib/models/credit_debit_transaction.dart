import 'package:intl/intl.dart';

class CDTransaction {
  static const String table = "credit_debit";

  static const String colTransactionId = "transactionId";
  static const String colPersonId = "personId";
  static const String colWalletId = "walletId";
  static const String colCredit = "credit";
  static const String colDebit = "debit";
  static const String colClosingBalance = "closingBalance";
  static const String colType = "type";
  static const String colDescription = "description";
  static const String colRemark = "remark";
  static const String colAddedOn = "addedOn";
  static const String colUpdatedOn = "updatedOn";
  static const String colIsCancel = "isCancel";

  static const String createTable = '''CREATE TABLE $table (
          $colTransactionId INTEGER primary key AUTOINCREMENT,
          $colPersonId INTEGER NOT NULL,
          $colWalletId INTEGER NOT NULL,
          $colCredit REAL NOT NULL,
          $colDebit REAL NOT NULL,
          $colClosingBalance REAL NOT NULL,
          $colType TEXT NOT NULL,
          $colDescription TEXT NULL,
          $colRemark TEXT NULL,
          $colAddedOn INTEGER NOT NULL,
          $colUpdatedOn INTEGER NULL,
          $colIsCancel INTEGER NULL DEFAULT 0
  )''';

  int? transactionId;
  int personId;
  int walletId;
  // double amount;
  double credit;
  double debit;
  double closingBalance;
  String type;  // IN/OUT
  String? description;
  String? remark;
  int addedOn;
  int? updatedOn;
  bool isCancel;

  CDTransaction(
      {this.transactionId,
      this.personId = 0,
      this.walletId = 1,
      this.credit = 0.0,
      this.debit = 0.0,
      this.closingBalance = 0.0,
      this.type = "IN",
      this.description,
      this.remark,
      this.addedOn=0,
      this.updatedOn,
      this.isCancel=false});


  String getDate() => DateFormat.yMd().add_jm().format(DateTime.fromMillisecondsSinceEpoch(addedOn));
  String getClosingBalance() => closingBalance<0?"Due ${closingBalance*-1}":"Balance $closingBalance";


  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'personId': personId,
      'walletId': walletId,
      'credit': credit,
      'debit': debit,
      'closingBalance': closingBalance,
      'type': type,
      'description': description,
      'remark': remark,
      'addedOn': addedOn,
      'updatedOn': updatedOn,
      'isCancel': isCancel ? 1:0
    };
  }

  factory CDTransaction.fromMap(Map<String, dynamic> map) {
    return CDTransaction(
      transactionId: map['transactionId'] as int?,
      personId: map['personId'] as int,
      walletId: map['walletId'] as int,
      credit: map['credit'] as double,
      debit: map['debit'] as double,
      closingBalance: map['closingBalance'] as double,
      type: map['type'] as String,
      description: map['description'] as String?,
      remark: map['remark'] as String?,
      addedOn: map['addedOn'] as int,
      updatedOn: map['updatedOn'] as int?,
      isCancel: map['isCancel'] as int == 1 ,
    );
  }

  String getDescription(){
    return "Transaction ID : $transactionId\n"
        "Wallet : $walletId\n"
        "Credit : +₹$credit\n"
        "Debit : -₹$debit\n"
        "Closing : ₹$closingBalance\n"
        "Time : ${getDate()}\n"
        "Remark : $remark";
  }
}

enum TransactionType{
  credit,debit
}