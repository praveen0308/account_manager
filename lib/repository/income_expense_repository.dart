import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/income_expense/category_model.dart';
import 'package:account_manager/models/income_expense/income_expense_model.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/models/person_transaction.dart';
import 'package:account_manager/models/wallet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class IncomeExpenseRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<bool> addNewCategory(CategoryModel category) async {
    Database db = await dbHelper.database;
    var result = await db.insert(CategoryModel.table, category.toMap());

    return result > 0;
  }

  Future<bool> addIncomeExpense(IncomeExpenseModel incomeExpenseModel) async {
    Database db = await dbHelper.database;
    var result =
        await db.insert(IncomeExpenseModel.table, incomeExpenseModel.toMap());

    return result > 0;
  }

  Future<List<IncomeExpenseModel>> getAllTransactions() async {
    Database db = await dbHelper.database;
    // SELECT IE.*,C.icon,C.name as categoryName from IncomeExpense as IE INNER JOIN Category as C on C.categoryId = IE.transactionId
    String query =
        "Select IE.*,C.icon,C.name as categoryName from ${IncomeExpenseModel.table} as IE inner join ${CategoryModel.table} as C on C.categoryId=IE.categoryId";
    var records = await db.rawQuery(query);

    return records.map((e) => IncomeExpenseModel.fromMap(e)).toList();
  }

  Future<List<IncomeExpenseModel>> getTransactionsAcDate(
      int start, int end) async {
    Database db = await dbHelper.database;
    // SELECT IE.*,C.icon,C.name as categoryName from IncomeExpense as IE INNER JOIN Category as C on C.categoryId = IE.transactionId
    String query =
        "Select IE.*,C.icon,C.name as categoryName from ${IncomeExpenseModel.table} as IE inner join ${CategoryModel.table} as C on C.categoryId=IE.categoryId where ${IncomeExpenseModel.colDate}>=$start and ${IncomeExpenseModel.colDate}<=$end";

    debugPrint("Query >>> $query");
    var records = await db.rawQuery(query);

    debugPrint("records >>> $records");
    return records.map((e) => IncomeExpenseModel.fromMap(e)).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    Database db = await dbHelper.database;
    var records = await db.query(CategoryModel.table);

    return records.map((e) => CategoryModel.fromMap(e)).toList();
  }
}
