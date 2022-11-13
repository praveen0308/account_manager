import 'package:account_manager/models/wallet_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../models/person_model.dart';
import '../../../repository/credit_debit_repository.dart';

part 'credit_debit_state.dart';

class CreditDebitCubit extends Cubit<CreditDebitState> {
  final CreditDebitRepository _creditDebitRepository;
  CreditDebitCubit(this._creditDebitRepository) : super(CreditDebitInitial());
  // String activeBusiness = "Business 1";
  int activeWalletId = 1;
  final List<PersonModel> persons = [];

  /*Future<void> fetchPersons() async {
    emit(LoadingPersons());
    try{
      var result = await _creditDebitRepository.getAllPersons();
      persons.clear();
      persons.addAll(result);
      emit(ReceivedPersons(result));

    }catch(e){
      debugPrint(e.toString());
    }

  }*/
  Future<void> fetchPersonsByWalletId(int walletId) async {
    emit(LoadingPersons());
    try{
      activeWalletId = walletId;
      var result = await _creditDebitRepository.getPersonsByWalletId(walletId);
      persons.clear();
      persons.addAll(result);
      emit(ReceivedPersons(result));

    }catch(e){
      debugPrint(e.toString());
    }

  }

  Future<void> fetchPersons() async {
    emit(LoadingPersons());
    try{

      var result = await _creditDebitRepository.getPersonsByWalletId(activeWalletId);
      persons.clear();
      persons.addAll(result);
      emit(ReceivedPersons(result));

    }catch(e){
      debugPrint(e.toString());
    }

  }

/*  Future<void> fetchStats() async {
    emit(LoadingStats());
    try{
      var result = await _creditDebitRepository.fetchStats();
      var wallet1 = result[0];
      var wallet2 = result[1];
      // var grandTotal = wallet1.credit+wallet2.credit-wallet1.debit-wallet2.debit;
      // emit(ReceivedStats(grandTotal, wallet1, wallet2));
    }catch(e){
      debugPrint(e.toString());

    }
  }*/

  Future<void> fetchStatsByWalletId() async {
    emit(LoadingStats());
    try{
      var result = await _creditDebitRepository.fetchStatsByWalletId(activeWalletId);


      var grandTotal = result.credit-result.debit;
      emit(ReceivedStats(grandTotal, result.credit, result.debit));
    }catch(e){
      debugPrint(e.toString());

    }
  }

  void applyFilter(int type){
    switch (type) {
      case 1:
        {
          persons.sort((a, b) => a.name.compareTo(b.name));
          emit(ReceivedPersons(persons));
        }
        break;
      case 2:
        {
          persons.sort((a, b) => b.credit.compareTo(a.credit));
          emit(ReceivedPersons(persons));
        }
        break;
      case 3:
        {
          persons.sort((a, b) => b.debit.compareTo(a.debit));
          emit(ReceivedPersons(persons));
        }
        break;
      case 4:
        {}
        break;
    }
  }

  void filterPersons(String q) {
    List<PersonModel> filteredPersons = [];
    filteredPersons.clear();
    if (q.isEmpty) {
      filteredPersons.addAll(persons);
    } else {
      for (var person in persons) {
        if (person.name.toLowerCase().contains(q.toLowerCase())) {
          filteredPersons.add(person);
        }
      }
    }
    emit(ReceivedPersons(filteredPersons));
  }

}
