import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../models/income_expense/category_model.dart';
import '../../../../../repository/category_repository.dart';

part 'category_detail_state.dart';

class CategoryDetailCubit extends Cubit<CategoryDetailState> {
  final CategoryRepository _categoryRepository;
  CategoryDetailCubit(this._categoryRepository) : super(CategoryDetailInitial());

  Future<void> updateCategory(CategoryModel category) async {
    emit(Updating());
    try{
      await _categoryRepository.updateCategory(category);
      emit(UpdatedSuccessfully());
    }catch(e){
      debugPrint(e.toString());
      emit(Error("Something went wrong!!!"));
    }

  }

  Future<void> deleteCategory(int categoryId) async {
    emit(Deleting());
    try{
      await _categoryRepository.deleteCategory(categoryId);
      emit(DeletedSuccessfully());
    }catch(e){
      debugPrint(e.toString());
      emit(Error("Something went wrong!!!"));
    }

  }

}
