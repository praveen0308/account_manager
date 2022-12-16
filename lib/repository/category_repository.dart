import 'package:account_manager/models/income_expense/category_model.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class CategoryRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<bool> addNewCategory(CategoryModel category) async {
    Database db = await dbHelper.database;
    var result = await db.insert(CategoryModel.table, category.toMap());
    return result > 0;
  }

  Future<bool> updateCategory(CategoryModel category) async {
    Database db = await dbHelper.database;
    var rows = category.toMap();
    rows.remove(CategoryModel.colCategoryId);
    var result = await db.update(CategoryModel.table, rows);
    return result > 0;
  }

  Future<bool> deleteCategory(int categoryId) async {
    Database db = await dbHelper.database;

    var result = await db.delete(CategoryModel.table, where: "${CategoryModel.colCategoryId}=?",whereArgs: [categoryId]);
    return result > 0;
  }


  Future<List<CategoryModel>> getAllCategories() async {
    Database db = await dbHelper.database;
    var result = await db.query(CategoryModel.table);
    return result.map((e) => CategoryModel.fromMap(e)).toList();
  }


}
