class PersonModel {
  static const String colPersonId = "personId";
  static const String colName = "name";
  static const String colMobileNumber = "mobileNumber";
  static const String colCredit = "credit";
  static const String colDebit = "debit";
  static const String colAddedOn = "addedOn";
  static const String table = "Person";


  static const String createTable = '''
  CREATE TABLE $table (
          $colPersonId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colName TEXT NOT NULL,
          $colMobileNumber TEXT NULL,
          $colCredit REAL NULL DEFAULT 0.0,
          $colDebit REAL NULL DEFAULT 0.0,
          $colAddedOn TEXT NULL
  )''';

  int? personId;
  String name;
  String mobileNumber;
  double credit;
  double debit;
  String addedOn;

  PersonModel({this.personId, this.name="", this.mobileNumber="", this.credit=0.0, this.debit=0.0,this.addedOn=""});

  Map<String, dynamic> toMap() {
    return {
      'personId': personId,
      'name': name,
      'mobileNumber': mobileNumber,
      'credit': credit,
      'debit': debit,
      'addedOn': addedOn
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      personId: map['personId'] as int,
      name: map['name'] as String,
      mobileNumber: map['mobileNumber'] as String,
      credit: map['credit'] as double,
      debit: map['debit'] as double,
      addedOn: map['addedOn'] as String
    );
  }
}
