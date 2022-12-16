import 'package:account_manager/models/person_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../repository/credit_debit_repository.dart';

part 'select_person_state.dart';

class SelectPersonCubit extends Cubit<SelectPersonState> {
  final CreditDebitRepository _creditDebitRepository;
  SelectPersonCubit(this._creditDebitRepository) : super(SelectPersonInitial());

  Future<void> fetchPersonsByWalletId(int walletId) async {
    emit(LoadingPersons());
    try{
      var result = await _creditDebitRepository.getPersonsByWalletId(walletId);
      emit(ReceivedPersons(result));

    }catch(e){
      debugPrint(e.toString());
      emit(Error("Something went wrong!!!"));
    }

  }
}
