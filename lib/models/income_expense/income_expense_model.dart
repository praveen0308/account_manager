class IncomeExpenseModel {
  static const String colTransactionId = "transactionId";
  static const String colCategoryId = "categoryId";
  static const String colType = "type";
  static const String colRemark = "remark";
  static const String colAmount = "amount";
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
          $colAddedOn TEXT NULL,
          $colUpdatedOn TEXT NULL,
          $colIsCancel INTEGER NOT NULL
  )''';

  int? transactionId;
  int categoryId;
  String type;
  String remark;
  double amount;
  String addedOn;
  String? updatedOn;
  bool isCancel;

//<editor-fold desc="Data Methods">

  IncomeExpenseModel({
    this.transactionId,
    required this.categoryId,
    required this.type,
    required this.remark,
    required this.amount,
    required this.addedOn,
    this.updatedOn,
    required this.isCancel,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeExpenseModel &&
          runtimeType == other.runtimeType &&
          transactionId == other.transactionId &&
          categoryId == other.categoryId &&
          type == other.type &&
          remark == other.remark &&
          amount == other.amount &&
          addedOn == other.addedOn &&
          updatedOn == other.updatedOn &&
          isCancel == other.isCancel);

  @override
  int get hashCode =>
      transactionId.hashCode ^
      categoryId.hashCode ^
      type.hashCode ^
      remark.hashCode ^
      amount.hashCode ^
      addedOn.hashCode ^
      updatedOn.hashCode ^
      isCancel.hashCode;

  @override
  String toString() {
    return 'IncomeExpenseModel{ transactionId: $transactionId, categoryId: $categoryId, type: $type, remark: $remark, amount: $amount, addedOn: $addedOn, updatedOn: $updatedOn, isCancel: $isCancel,}';
  }

  IncomeExpenseModel copyWith({
    int? transactionId,
    int? categoryId,
    String? type,
    String? remark,
    double? amount,
    String? addedOn,
    String? updatedOn,
    bool? isCancel,
  }) {
    return IncomeExpenseModel(
      transactionId: transactionId ?? this.transactionId,
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
      remark: remark ?? this.remark,
      amount: amount ?? this.amount,
      addedOn: addedOn ?? this.addedOn,
      updatedOn: updatedOn ?? this.updatedOn,
      isCancel: isCancel ?? this.isCancel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'categoryId': categoryId,
      'type': type,
      'remark': remark,
      'amount': amount,
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
      remark: map['remark'] as String,
      amount: map['amount'] as double,
      addedOn: map['addedOn'] as String,
      updatedOn: map['updatedOn'] as String,
      isCancel: map['isCancel'] as bool,
    );
  }

//</editor-fold>
}
