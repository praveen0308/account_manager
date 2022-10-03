import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/income_expense/category_model.dart';
import 'package:account_manager/models/income_expense/income_expense_model.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/models/person_transaction.dart';
import 'package:account_manager/models/wallet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class IncomeExpenseRepository{
  final dbHelper = DatabaseHelper.instance;

  Future<bool> addNewCategory(CategoryModel category) async {
    Database db = await dbHelper.database;
    var result = await db.insert(CategoryModel.table,category.toMap());

    return result>0;
  }

  Future<bool> addIncomeExpense(IncomeExpenseModel incomeExpenseModel) async {
    Database db = await dbHelper.database;
    var result = await db.insert(IncomeExpenseModel.table,incomeExpenseModel.toMap());

    return result>0;
  }


  Future<List<IncomeExpenseModel>> getAllTransactions() async {
    Database db = await dbHelper.database;
    var records = await db.query(IncomeExpenseModel.table);

    return records.map((e) => IncomeExpenseModel.fromMap(e)).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    Database db = await dbHelper.database;
    var records = await db.query(CategoryModel.table);

    return records.map((e) => CategoryModel.fromMap(e)).toList();
  }


}