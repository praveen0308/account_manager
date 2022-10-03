import 'package:intl/intl.dart';

class CDTransaction {
  static const String table = "credit_debit";

  static const String colTransactionId = "transactionId";
  static const String colPersonId = "personId";
  static const String colWalletId = "walletId";
  static const String colAmount = "amount";
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
          $colAmount REAL NOT NULL,
          $colType TEXT NOT NULL,
          $colDescription TEXT NULL,
          $colRemark TEXT NULL,
          $colAddedOn TEXT NOT NULL,
          $colUpdatedOn TEXT NULL,
          $colIsCancel INTEGER NULL DEFAULT 0
  )''';

  int? transactionId;
  int personId;
  int walletId;
  double amount;
  String type;  // IN/OUT
  String? description;
  String? remark;
  String addedOn;
  String? updatedOn;
  bool isCancel;

  CDTransaction(
      {this.transactionId,
      this.personId = 0,
      this.walletId = 1,
      this.amount = 0.0,
      this.type = "IN",
      this.description,
      this.remark,
      this.addedOn = "",
      this.updatedOn,
      this.isCancel=false});


  String getDate() => DateFormat.yMd().add_jm().format(DateTime.parse(addedOn));


  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'personId': personId,
      'walletId': walletId,
      'amount': amount,
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
      amount: map['amount'] as double,
      type: map['type'] as String,
      description: map['description'] as String?,
      remark: map['remark'] as String?,
      addedOn: map['addedOn'] as String,
      updatedOn: map['updatedOn'] as String?,
      isCancel: map['isCancel'] as int == 1 ,
    );
  }
}
