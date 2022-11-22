part of 'manage_categories_cubit.dart';

@immutable
abstract class ManageCategoriesState {}

class ManageCategoriesInitial extends ManageCategoriesState {}
class Loading extends ManageCategoriesState {}

class Error extends ManageCategoriesState {
  final String msg;

  Error(this.msg);
}
class ReceivedCategories extends ManageCategoriesState {
  final List<CategoryModel> categories;

  ReceivedCategories(this.categories);
}

class NoCategories extends ManageCategoriesState {}