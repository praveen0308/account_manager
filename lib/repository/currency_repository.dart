import 'package:account_manager/models/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class CurrencyRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Currency>> getAllCurrencies() async {
    Database db = await dbHelper.database;
    var records = await db.query(Currency.table);
    debugPrint(records.toString());
    return records.map((e) => Currency.fromMap(e)).toList();
  }

  Future<List<Currency>> getActiveCurrencies() async {
    Database db = await dbHelper.database;
    var records = await db.query(Currency.table,
        where: "${Currency.columnIsActive}=?", whereArgs: [1]);
    debugPrint(records.toString());
    return records.map((e) => Currency.fromMap(e)).toList();
  }

  Future<bool> updateCurrencies(List<Currency> currencies) async {
    Database db = await dbHelper.database;
    try {
      for (var currency in currencies) {
        var row = {Currency.columnIsActive: currency.isActive ? 1 : 0};

        await db.update(Currency.table, row,
            where: "${Currency.columnId}=?", whereArgs: [currency.id]);
      }
      return true;
    } catch (e) {
      debugPrint("Error occurred !!!");
      debugPrint(e.toString());
    }

    return false;
  }
}
