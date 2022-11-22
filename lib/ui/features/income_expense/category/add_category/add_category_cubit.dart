import 'package:account_manager/models/income_expense/category_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../repository/category_repository.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  final CategoryRepository _categoryRepository;
  AddCategoryCubit(this._categoryRepository) : super(AddCategoryInitial());

  Future<void> addNewCategory(CategoryModel category) async {
    emit(Loading());
    try{

      var result = await _categoryRepository.addNewCategory(category);
      if(result){
        emit(AddedSuccessfully());
      }else{
        emit(Failed());
      }


    }catch(e){
      debugPrint(e.toString());
    }

  }


}
