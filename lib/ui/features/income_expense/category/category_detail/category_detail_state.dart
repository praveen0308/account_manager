part of 'category_detail_cubit.dart';

@immutable
abstract class CategoryDetailState {}

class CategoryDetailInitial extends CategoryDetailState {}
class Updating extends CategoryDetailState {}
class Deleting extends CategoryDetailState {}
class UpdatedSuccessfully extends CategoryDetailState {}
class DeletedSuccessfully extends CategoryDetailState {}
class Error extends CategoryDetailState {
  final String msg;

  Error(this.msg);
}


