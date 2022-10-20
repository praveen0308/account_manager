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
    bool isCredit = transaction.type == TransactionType.credit.name;

    Database db = await dbHelper.database;
    var lastTransactionReq =
        await getTransactionsByPersonId(personModel.personId!);
    if (lastTransactionReq.isNotEmpty) {
      var lastTransaction = lastTransactionReq.last;
      if (isCredit) {
        transaction.closingBalance =
            lastTransaction.closingBalance + transaction.credit;
      } else {
        transaction.closingBalance =
            lastTransaction.closingBalance - transaction.debit;
      }
    } else {
      transaction.closingBalance =
          isCredit ? transaction.credit : transaction.debit;
    }
    await db.insert(CDTransaction.table, transaction.toMap());

    Map<String, dynamic> row;

    if (isCredit) {
      personModel.credit += transaction.credit;
      row = {PersonModel.colCredit: personModel.credit};
    } else {
      personModel.debit += transaction.debit;
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
        where: "${CDTransaction.colPersonId}=?", whereArgs: [personId]);

    return records.map((e) => CDTransaction.fromMap(e)).toList();
  }

  Future<bool> deleteCDTransaction(
      int transactionId) async {
    // cashTransactionModel.addedOn = DateTime.now().toString();
    Database db = await dbHelper.database;
    var result = await db.delete(CDTransaction.table,
        where: "${CDTransaction.colTransactionId}=?",
        whereArgs: [transactionId]);
    debugPrint("Deleted successfully >>> result : $result");
    return result > 0;
  }

  Future<List<WalletModel>> fetchStats() async {
    Database db = await dbHelper.database;

    /*var query =
        "SELECT sum(${CDTransaction.colCredit}) as result from ${CDTransaction.table} GROUP by ${CDTransaction.colWalletId},${CDTransaction.colType}";
    */
    var query = "SELECT ${CDTransaction.colWalletId},sum(${CDTransaction.colCredit}) as credit,sum(${CDTransaction.colDebit}) as debit from credit_debit group by ${CDTransaction.colWalletId};";
    var result = await db.rawQuery(query);

    List<WalletModel> wallets = [];
    wallets.add(WalletModel(1, "Wallet 1", result[0]['credit'] as double, result[0]['debit'] as double));
    wallets.add(WalletModel(2, "Wallet 2", result[1]['credit'] as double, result[1]['debit'] as double));

    return wallets;
  }
}
