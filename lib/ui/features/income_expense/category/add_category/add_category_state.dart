part of 'add_category_cubit.dart';

@immutable
abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}
class AddingCategory extends AddCategoryState {}
class Added extends AddCategoryState {}
class Failed extends AddCategoryState {}
