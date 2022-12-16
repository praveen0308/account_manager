part of 'select_person_cubit.dart';

@immutable
abstract class SelectPersonState {}

class SelectPersonInitial extends SelectPersonState {}
class LoadingPersons extends SelectPersonState {}
class Error extends SelectPersonState {
  final String msg;

  Error(this.msg);
}
class NoPersons extends SelectPersonState {}
class ReceivedPersons extends SelectPersonState {
  final List<PersonModel> persons;

  ReceivedPersons(this.persons);
}
