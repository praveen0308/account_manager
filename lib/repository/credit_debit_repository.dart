import 'package:account_manager/models/cash_transaction.dart';
import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/currency.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/models/person_transaction.dart';
import 'package:account_manager/models/wallet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class CreditDebitRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<bool> addNewPerson(PersonModel person) async {
    Database db = await dbHelper.database;
    var result = await db.insert(PersonModel.table, person.toMap());

    return result > 0;
  }

  Future<PersonModel> addNewTransaction(
      PersonModel personModel, CDTransaction transaction) async {
    Database db = await dbHelper.database;

    var result = await db.insert(CDTransaction.table, transaction.toMap());

    Map<String, dynamic> row;

    if (transaction.type == "IN") {
      personModel.credit = personModel.credit + transaction.amount;
      row = {PersonModel.colCredit: personModel.credit};
    } else {
      personModel.debit = personModel.debit + transaction.amount;
      row = {PersonModel.colDebit: personModel.debit};
    }

    await db.update(PersonModel.table, row,
        where: "${PersonModel.colPersonId}=?",
        whereArgs: [transaction.personId]);

    return personModel;
  }

  Future<List<PersonModel>> getAllPersons() async {
    Database db = await dbHelper.database;
    var records = await db.query(PersonModel.table);

    return records.map((e) => PersonModel.fromMap(e)).toList();
  }

  Future<List<CDTransaction>> getAllTransactions() async {
    Database db = await dbHelper.database;
    var records = await db.query(CDTransaction.table);

    return records.map((e) => CDTransaction.fromMap(e)).toList();
  }

  Future<List<CDTransaction>> getTransactionsByPersonId(int personId) async {
    Database db = await dbHelper.database;
    var records = await db.query(CDTransaction.table,
        where: "${CDTransaction.colPersonId}=?",
      whereArgs: [personId]
    );

    return records.map((e) => CDTransaction.fromMap(e)).toList();
  }

  Future<List<WalletModel>> fetchStats() async {

    Database db = await dbHelper.database;

    var query = "SELECT sum(${PersonTransaction.colAmount}) as result from ${CDTransaction.table} GROUP by ${CDTransaction.colWalletId},${CDTransaction.colType}";
    var result = await db.rawQuery(query);
    List<double> fRes = result.map((e) => e['result'] as double).toList();

    List<WalletModel> wallets = [];
    wallets.add(WalletModel(1, "Wallet 1", fRes[0], fRes[1]));
    wallets.add(WalletModel(2, "Wallet 2", fRes[2], fRes[3]));




    return wallets;
  }
}
