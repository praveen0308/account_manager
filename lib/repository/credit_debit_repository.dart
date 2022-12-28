import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/models/wallet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class CreditDebitRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<bool> addNewPerson(PersonModel person) async {
    Database db = await dbHelper.database;
    var exists = await checkPersonExists(person);
    if(exists){
      return false;
    }else{
      var result = await db.insert(PersonModel.table, person.toMap());
      return true;
    }



  }

  Future<bool> checkPersonExists(PersonModel person) async {
    Database db = await dbHelper.database;
    var result = await db.query(PersonModel.table,
        where:
            "${PersonModel.colWalletId}=? and ${PersonModel.colMobileNumber}=?",
        whereArgs: [person.walletId, person.mobileNumber]);

    return result.isNotEmpty;
  }

/*
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
*/

  Future<PersonModel> addNewTransaction1(
      PersonModel personModel, CDTransaction transaction) async {
    bool isCredit = transaction.type == TransactionType.credit.name;

    Database db = await dbHelper.database;
    transaction.closingBalance = 0;
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

  Future<PersonModel> deleteCDTransaction(
      PersonModel personModel, CDTransaction transaction) async {
    // cashTransactionModel.addedOn = DateTime.now().toString();
    bool isCredit = transaction.type == TransactionType.credit.name;
    Database db = await dbHelper.database;
    var result = await db.delete(CDTransaction.table,
        where: "${CDTransaction.colTransactionId}=?",
        whereArgs: [transaction.transactionId]);
    debugPrint("Deleted successfully >>> result : $result");
    Map<String, dynamic> row;

    if (isCredit) {
      personModel.credit -= transaction.credit;
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
  Future<PersonModel> updateCDTransactionStatus(
      PersonModel personModel, CDTransaction transaction,bool isCancel) async {
    // cashTransactionModel.addedOn = DateTime.now().toString();

    int cancelStatus = isCancel?1:0;
    print("Transaction ID >>> ${transaction.transactionId}" );
    bool isCredit = transaction.type == TransactionType.credit.name;
    Database db = await dbHelper.database;
    var result = await db.update(CDTransaction.table,{CDTransaction.colIsCancel:cancelStatus},
        where: "${CDTransaction.colTransactionId}=?",
        whereArgs: [transaction.transactionId]);
    debugPrint("Deleted successfully >>> result : $result");
    Map<String, dynamic> row;

    if(isCancel){
      if (isCredit) {
        personModel.credit += transaction.credit;
        row = {PersonModel.colCredit: personModel.credit};
      } else {
        personModel.debit -= transaction.debit;
        row = {PersonModel.colDebit: personModel.debit};
      }
    }else{
      if (isCredit) {
        personModel.credit -= transaction.credit;
        row = {PersonModel.colCredit: personModel.credit};
      } else {
        personModel.debit += transaction.debit;
        row = {PersonModel.colDebit: personModel.debit};
      }
    }


    await db.update(PersonModel.table, row,
        where: "${PersonModel.colPersonId}=?",
        whereArgs: [transaction.personId]);

    return personModel;
  }


  Future<PersonModel> updateCDTransaction(
      PersonModel personModel, CDTransaction transaction) async {
    // cashTransactionModel.addedOn = DateTime.now().toString();
    bool isCredit = transaction.type == TransactionType.credit.name;
    Database db = await dbHelper.database;
    var result = await db.update(CDTransaction.table,transaction.toMap(),
        where: "${CDTransaction.colTransactionId}=?",
        whereArgs: [transaction.transactionId]);
    debugPrint("Deleted successfully >>> result : $result");
    Map<String, dynamic> row;

    if (isCredit) {
      personModel.credit -= transaction.credit;
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

  Future<List<PersonModel>> getPersonsByWalletId(int walletId) async {
    Database db = await dbHelper.database;
    var records = await db.query(PersonModel.table,
        where: "${PersonModel.colWalletId}=?", whereArgs: [walletId]);

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

  Future<List<CDTransaction>> getTransactionsByPersonIdAcDate(
      int personId, int from, int to) async {
    Database db = await dbHelper.database;
    var records = await db.query(CDTransaction.table,
        where:
            "${CDTransaction.colPersonId}=? and ${CDTransaction.colAddedOn}>=? and ${CDTransaction.colAddedOn}<=?",
        whereArgs: [personId, from, to]);

    return records.map((e) => CDTransaction.fromMap(e)).toList();
  }

  Future<List<CDTransaction>> getTransactionsByWalletIdAcDate(
      int walletId, int from, int to) async {
    Database db = await dbHelper.database;
    var query = "select CD.*,P.${PersonModel.colName} as personName from ${CDTransaction.table} as CD left join ${PersonModel.table} as P on P.${PersonModel.colPersonId}=CD.${CDTransaction.colPersonId} where CD.${CDTransaction.colWalletId}=$walletId and CD.${CDTransaction.colAddedOn}>=$from and CD.${CDTransaction.colAddedOn}<=$to";
    /*var records = await db.query(CDTransaction.table,
        where:
        "${CDTransaction.colWalletId}=? and ${CDTransaction.colAddedOn}>=? and ${CDTransaction.colAddedOn}<=?",
        whereArgs: [walletId, from, to]);
*/
    var records = await db.rawQuery(query);
    return records.map((e) => CDTransaction.fromMap(e)).toList();
  }


  Future<List<WalletModel>> fetchStats() async {
    Database db = await dbHelper.database;

    /*var query =
        "SELECT sum(${CDTransaction.colCredit}) as result from ${CDTransaction.table} GROUP by ${CDTransaction.colWalletId},${CDTransaction.colType}";
    */
    var query =
        "SELECT ${CDTransaction.colWalletId},sum(${CDTransaction.colCredit}) as credit,sum(${CDTransaction.colDebit}) as debit from credit_debit group by ${CDTransaction.colWalletId};";
    var result = await db.rawQuery(query);

    List<WalletModel> wallets = [];
    wallets.add(WalletModel(1, "Wallet 1", result[0]['credit'] as double,
        result[0]['debit'] as double));
    wallets.add(WalletModel(2, "Wallet 2", result[1]['credit'] as double,
        result[1]['debit'] as double));

    return wallets;
  }

  Future<WalletModel> fetchStatsByWalletId(int walletId) async {
    Database db = await dbHelper.database;

    /*var query =
        "SELECT sum(${CDTransaction.colCredit}) as result from ${CDTransaction.table} GROUP by ${CDTransaction.colWalletId},${CDTransaction.colType}";
    */
    var query =
        "SELECT ${CDTransaction.colWalletId},sum(${CDTransaction.colCredit}) as credit,sum(${CDTransaction.colDebit}) as debit from credit_debit where ${CDTransaction.colWalletId}=$walletId and ${CDTransaction.colIsCancel}=0;";
    var result = await db.rawQuery(query);
    print("Stats Result >>> $result");
    if (result[0]['walletId'] == null) {
      return WalletModel(walletId, "Business $walletId}", 0, 0);
    } else {
      return WalletModel(
          result[0]['walletId'] as int,
          "Business ${result[0]['walletId']}",
          result[0]['credit'] as double,
          result[0]['debit'] as double);
    }
  }
}
