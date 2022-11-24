import 'package:intl/intl.dart';

class IncomeExpenseModel {
  static const String colTransactionId = "transactionId";
  static const String colCategoryId = "categoryId";
  static const String colType = "type";
  static const String colRemark = "remark";
  static const String colAmount = "amount";
  static const String colDate = "date";
  static const String colAddedOn = "addedOn";
  static const String colUpdatedOn = "updatedOn";
  static const String colIsCancel = "isCancel";

  static const String table = "IncomeExpense";

  static const String createTable = '''CREATE TABLE $table (
          $colTransactionId INTEGER primary key AUTOINCREMENT,
          $colCategoryId INTEGER NOT NULL,
          $colType TEXT NOT NULL,
          $colRemark TEXT NULL,
          $colAmount REAL NOT NULL,
          $colDate INTEGER NULL,
          $colAddedOn INTEGER NULL,
          $colUpdatedOn INTEGER NULL,
          $colIsCancel INTEGER NOT NULL
  )''';

  int? transactionId;
  int categoryId;
  String type;
  String? remark;
  double amount;
  int date;
  int addedOn;
  int? updatedOn;
  bool isCancel;
  int? icon;
  String? categoryName;

  IncomeExpenseModel({
    this.transactionId,
    required this.categoryId,
    required this.type,
    this.remark,
    required this.amount,
    this.date = 0,
    this.addedOn = 0,
    this.updatedOn,
    this.isCancel=true,
    this.icon=0,
    this.categoryName="",
  });

  String getDate() => DateFormat("dd MMM yy").add_jm().format(DateTime.fromMillisecondsSinceEpoch(addedOn));
  String getAmount() {
    return amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 1);
  }
  @override
  String toString() {
    return 'IncomeExpenseModel{ transactionId: $transactionId, categoryId: $categoryId, type: $type, remark: $remark, amount: $amount, addedOn: $addedOn, updatedOn: $updatedOn, isCancel: $isCancel,}';
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'categoryId': categoryId,
      'type': type,
      'remark': remark,
      'amount': amount,
      'date': date,
      'addedOn': addedOn,
      'updatedOn': updatedOn,
      'isCancel': isCancel,
    };
  }

  factory IncomeExpenseModel.fromMap(Map<String, dynamic> map) {
    return IncomeExpenseModel(
      transactionId: map['transactionId'] as int,
      categoryId: map['categoryId'] as int,
      type: map['type'] as String,
      remark: map['remark'] as String?,
      amount: map['amount'] as double,
      date: map['date'] as int,
      addedOn: map['addedOn'] as int,
      updatedOn: map['updatedOn'] as int?,
      isCancel: map['isCancel'] as int == 1,
      icon: map['icon'] as int?,
      categoryName: map['categoryName'] as String?
    );
  }

//</editor-fold>
}
