import 'package:account_manager/models/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class CurrencyRepository{
  final dbHelper = DatabaseHelper.instance;

  Future<List<Currency>> getAllCurrencies() async {
    Database db = await dbHelper.database;
    var records = await db.query(Currency.table);
    debugPrint(records.toString());
    return records.map((e) => Currency.fromMap(e)).toList();
  }

}