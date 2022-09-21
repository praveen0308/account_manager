class CashTransactionTable {
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
          $columnManuallyAdded REAL,
          $columnManuallySubtracted REAL,
          $columnDenominationTotal REAL,
          $columnGrandTotal REAL,
          $columnNoOfNotes INTEGER,
          $columnTransactionDescription TEXT,
          $columnName TEXT,
          $columnMobileNumber TEXT,
          $columnAccountNumber TEXT,
          $columnRemark TEXT,
          $columnAddedOn TEXT,
          $columnUpdatedOn TEXT
  )''';


}
