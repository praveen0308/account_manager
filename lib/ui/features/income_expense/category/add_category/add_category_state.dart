part of 'add_category_cubit.dart';

@immutable
abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}
class Loading extends AddCategoryState {}
class AddedSuccessfully extends AddCategoryState {}
class Failed extends AddCategoryState {}
