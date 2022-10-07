import 'package:account_manager/models/cash_transaction.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class CashTransactionRepository{
  final dbHelper = DatabaseHelper.instance;

  Future<bool> addCashTransaction(CashTransactionModel cashTransactionModel) async {
    // cashTransactionModel.addedOn = DateTime.now().toString();
    Database db = await dbHelper.database;
    var result = await db.insert(CashTransactionModel.table, cashTransactionModel.toMap());
    debugPrint("Operation done >>> result : $result");
    return result>0;
  }


  Future<List<CashTransactionModel>> fetchAllTransactions() async {
    Database db = await dbHelper.database;
    var records = await db.query(CashTransactionModel.table);
    debugPrint("Transactions >>> $records");
    return records.map((e) => CashTransactionModel.fromMap(e)).toList();
  }


}