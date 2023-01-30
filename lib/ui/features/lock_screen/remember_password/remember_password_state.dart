part of 'remember_password_cubit.dart';

@immutable
abstract class RememberPasswordState {}

class RememberPasswordInitial extends RememberPasswordState {}
class Loading extends RememberPasswordState {}
class SavedSuccessfully extends RememberPasswordState {}

