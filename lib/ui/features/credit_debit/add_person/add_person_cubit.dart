import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/repository/credit_debit_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_person_state.dart';

class AddPersonCubit extends Cubit<AddPersonState> {
  final CreditDebitRepository _creditDebitRepository;
  AddPersonCubit(this._creditDebitRepository) : super(AddPersonInitial());

  Future<void> addNewPerson(PersonModel personModel) async {
    emit(AddingPerson());
    try{
      personModel.addedOn = DateTime.now().toString();
      var result = await _creditDebitRepository.addNewPerson(personModel);
      if(result) {
        emit(AddedSuccessfully());
      } else {
        emit(Failed());
      }
    }catch(e){
      emit(Failed());
      debugPrint(e.toString());
    }

  }
}
