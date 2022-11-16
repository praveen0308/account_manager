import 'package:account_manager/models/credit_debit_transaction.dart';
import 'package:account_manager/models/person_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../repository/credit_debit_repository.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {

  final CreditDebitRepository _creditDebitRepository;
  AddTransactionCubit(this._creditDebitRepository) : super(AddTransactionInitial());

  Future<void> addNewTransaction(PersonModel personModel,CDTransaction transaction) async {
    emit(AddingTransaction());
    try{
      transaction.addedOn = DateTime.now().millisecondsSinceEpoch;
      var result = await _creditDebitRepository.addNewTransaction(personModel,transaction);
      if(result!=null) {
        emit(AddedSuccessfully(result));
      } else {
        emit(Failed());
      }
    }catch(e){
      emit(Failed());
      debugPrint(e.toString());
    }

  }
}
