class CategoryModel {

  static const String colCategoryId = "categoryId";
  static const String colType = "type";
  static const String colName = "name";
  static const String colDescription = "description";
  static const String colIcon = "icon";
  static const String table = "Category";

  static const String createTable = '''CREATE TABLE $table (
          $colCategoryId INTEGER primary key AUTOINCREMENT,
          $colIcon INTEGER NULL,
          $colType TEXT NOT NULL,
          $colName TEXT NOT NULL,
          $colDescription TEXT NOT NULL
          
  )''';



  int? categoryId;
  int icon;
  String type;
  String name;
  String description;


  CategoryModel(
  {this.categoryId,this.icon=0, this.type="", this.name="", this.description=""});

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'type': type,
      'name': name,
      'description': description,
      'icon': icon,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] as int,
      type: map['type'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      icon: map['icon'] as int,
    );
  }
}
