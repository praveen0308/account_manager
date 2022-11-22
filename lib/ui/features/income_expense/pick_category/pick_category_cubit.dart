import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../models/income_expense/category_model.dart';
import '../../../../repository/category_repository.dart';
import '../../../../utils/income_type.dart';

part 'pick_category_state.dart';

class PickCategoryCubit extends Cubit<PickCategoryState> {
  final CategoryRepository _categoryRepository;
  PickCategoryCubit(this._categoryRepository) : super(PickCategoryInitial());


  Future<void> fetchCategories(IncomeType type) async {
    emit(Loading());
    try{

      var result = await _categoryRepository.getAllCategories();
      result = result.where((element) => element.type==type.toString()).toList();
      if(result.isNotEmpty){

        emit(ReceivedCategories(result));
      }else{
        emit(NoCategories());
      }


    }on Exception catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }

  }
}
