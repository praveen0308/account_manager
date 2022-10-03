class PersonTransaction{
  static const String colTransactionId = "transactionId";
  static const String colPersonId = "personId";
  static const String colWalletId = "walletId";
  static const String colAmount = "amount";
  static const String colType = "type";
  static const String colDescription = "description";
  static const String colAddedOn = "addedOn";
  static const String colUpdatedOn = "updatedOn";
  static const String colIsCancel = "isCancel";
  static const String table = "PersonTransactions";


  static const String createTable = '''
  CREATE TABLE $table (
          $colTransactionId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colPersonId INTEGER NOT NULL,
          $colWalletId INTEGER NOT NULL,
          $colAmount REAL NOT NULL,
          $colType TEXT NOT NULL,
          $colDescription TEXT NULL,
          $colAddedOn TEXT NULL,
          $colUpdatedOn TEXT NULL,
          $colIsCancel INTEGER NULL DEFAULT 0
  )''';

  int? transactionId;
  int personId;
  int walletId;  // 1/2
  double amount;
  String type;  // credit/debit
  String description;
  String addedOn;
  String updatedOn;
  bool isCancel;

  PersonTransaction({
      this.transactionId,
      this.personId=0,
      this.walletId=1,
      this.amount=0.0,
      this.type="",
      this.description="",
      this.addedOn="",
      this.updatedOn="",
      this.isCancel=false});

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'personId': personId,
      'walletId': walletId,
      'amount': amount,
      'type': type,
      'description': description,
      'addedOn': addedOn,
      'updatedOn': updatedOn,
      'isCancel': isCancel,
    };
  }

  factory PersonTransaction.fromMap(Map<String, dynamic> map) {
    return PersonTransaction(
      transactionId: map['transactionId'] as int,
      personId: map['personId'] as int,
      walletId: map['walletId'] as int,
      amount: map['amount'] as double,
      type: map['type'] as String,
      description: map['description'] as String,
      addedOn: map['addedOn'] as String,
      updatedOn: map['updatedOn'] as String,
      isCancel: map['isCancel'] as bool,
    );
  }
}