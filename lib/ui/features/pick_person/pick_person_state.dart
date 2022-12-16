part of 'pick_person_cubit.dart';

@immutable
abstract class PickPersonState {}

class PickPersonInitial extends PickPersonState {}
class LoadingPersons extends PickPersonState {}
class AddingTransaction extends PickPersonState {}
class AddedTransaction extends PickPersonState {}
class NoPersons extends PickPersonState {}
class ReceivedPersons extends PickPersonState {
  final List<PersonModel> persons;

  ReceivedPersons(this.persons);

}
class Error extends PickPersonState {
  final String msg;

  Error(this.msg);
}
