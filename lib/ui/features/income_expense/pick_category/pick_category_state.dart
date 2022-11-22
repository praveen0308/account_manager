part of 'pick_category_cubit.dart';

@immutable
abstract class PickCategoryState {}

class PickCategoryInitial extends PickCategoryState {}
class Loading extends PickCategoryState {}
class Error extends PickCategoryState {
  final String msg;

  Error(this.msg);

}
class NoCategories extends PickCategoryState {}
class ReceivedCategories extends PickCategoryState {
  final List<CategoryModel> categories;

  ReceivedCategories(this.categories);

}
