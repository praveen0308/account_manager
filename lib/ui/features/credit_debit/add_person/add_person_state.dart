part of 'add_person_cubit.dart';

@immutable
abstract class AddPersonState {}

class AddPersonInitial extends AddPersonState {}
class AddingPerson extends AddPersonState {}
class AddedSuccessfully extends AddPersonState {}
class Failed extends AddPersonState {}
