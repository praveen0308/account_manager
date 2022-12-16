import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/credit_debit_transaction.dart';
import '../../../models/person_model.dart';
import '../../../repository/credit_debit_repository.dart';

part 'pick_person_state.dart';

class PickPersonCubit extends Cubit<PickPersonState> {
  final CreditDebitRepository _creditDebitRepository;

  PickPersonCubit(this._creditDebitRepository) : super(PickPersonInitial());

  Future<void> fetchPersonsByWalletId(int walletId) async {
    emit(LoadingPersons());
    try {
      var result = await _creditDebitRepository.getPersonsByWalletId(walletId);
      if (result.isEmpty) {
        emit(NoPersons());
      } else {
        emit(ReceivedPersons(result));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(Error("Something went wrong!!!"));
    }
  }

  Future<void> addNewTransaction(PersonModel personModel,CDTransaction transaction) async {
    emit(AddingTransaction());
    try{
      transaction.addedOn = DateTime.now().millisecondsSinceEpoch;
      var result = await _creditDebitRepository.addNewTransaction1(personModel,transaction);
      emit(AddedTransaction());

    }catch(e){
      debugPrint(e.toString());
      emit(Error("Something went wrong!!!"));
    }

  }
}
