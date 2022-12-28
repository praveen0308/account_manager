import 'dart:async';
import 'dart:io';

import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/currency.dart';
import 'package:account_manager/models/income_expense/category_model.dart';
import 'package:account_manager/models/income_expense/income_expense_model.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/models/person_transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';

class DatabaseHelper {
  static const _databaseName = "accountManager.db";
  static const _databaseVersion = 2;

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(Currency.createTable);
    await _populateCurrencies(db, Currency.getInitialTransactions());

    await db.execute(CashTransactionModel.createTable);
    await db.execute(PersonModel.createTable);
    // await db.execute(PersonTransaction.createTable);
    await db.execute(CategoryModel.createTable);
    await db.execute(IncomeExpenseModel.createTable);
    await db.execute(CDTransaction.createTable);
    await db.execute(NoteModel.createTable);
  }

  Future _populateCurrencies(Database db, List<Currency> currencies) async {
    try {
      await db.transaction((txn) async {
        currencies.forEach((obj) async {
          await txn.insert(Currency.table, obj.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);
          debugPrint("Populated currencies successfully !!!");
        });
      });
    } catch (er) {
      debugPrint("Error $er");
    }
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    // await db.execute("ALTER TABLE ${CDTransaction.table} ADD COLUMN walletId");
    await db.execute(NoteModel.createTable);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<File> dBToCopy() async {
    final db = await instance.database;
    final dbPath = await getDatabasesPath();
    var afile = File(dbPath);
    return afile;
  }
}
