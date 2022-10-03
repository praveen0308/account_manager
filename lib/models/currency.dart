class Currency {
  static const String table = "currency";
  static const String columnId = "id";
  static const String columnItem = "item";
  static const String columnIsActive = "isActive";

  static const String createTable = '''
  CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnItem INTEGER NOT NULL,
          $columnIsActive INTEGER NOT NULL
  )''';

  int? id;
  int item;
  int? qty;
  final bool isActive;


  Currency({this.id, required this.item,this.qty=0, this.isActive = true});

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'isActive': isActive ? 1 : 0,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map['id'] as int,
      item: map['item'] as int,
      isActive: map['isActive'] == 1,
    );
  }

  static List<Currency> getInitialTransactions() {
    List<Currency> data = [];
    data.add(Currency(item: 2000));
    data.add(Currency(item: 500));
    data.add(Currency(item: 200));
    data.add(Currency(item: 100));
    data.add(Currency(item: 50));
    data.add(Currency(item: 20));
    data.add(Currency(item: 10));
    data.add(Currency(item: 5));
    data.add(Currency(item: 2));
    data.add(Currency(item: 1));

    return data;
  }

  static Map<int, int> getCurrencyMap() => {
        2000: 0,
        500: 0,
        200: 0,
        100: 0,
        50: 0,
        20: 0,
        10: 0,
        5: 0,
        2: 0,
        1: 0,
      };
}
