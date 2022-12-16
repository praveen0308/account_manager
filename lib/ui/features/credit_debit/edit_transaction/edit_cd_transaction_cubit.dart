import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../models/person_model.dart';
import '../../../../repository/credit_debit_repository.dart';

part 'edit_cd_transaction_state.dart';

class EditCdTransactionCubit extends Cubit<EditCdTransactionState> {
  final CreditDebitRepository _creditDebitRepository;

  EditCdTransactionCubit(this._creditDebitRepository)
      : super(EditCdTransactionInitial());

  Future<void> updateCDTransaction(
      PersonModel personModel, CDTransaction transaction) async {
    emit(Updating());
    try {
      transaction.addedOn = DateTime.now().millisecondsSinceEpoch;
      await _creditDebitRepository.updateCDTransaction(
          personModel, transaction);
      emit(UpdatedSuccessfully());
    } catch (e) {
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }
  }

  Future<List<PersonModel>> fetchPersonsByWalletId(int walletId) async {
    return await _creditDebitRepository.getPersonsByWalletId(walletId);
  }
}
