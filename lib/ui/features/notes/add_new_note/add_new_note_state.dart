part of 'add_new_note_cubit.dart';

@immutable
abstract class AddNewNoteState {}

class AddNewNoteInitial extends AddNewNoteState {}
class AddingNote extends AddNewNoteState {}
class AddedSuccessfully extends AddNewNoteState {}
class DraftedSuccessfully extends AddNewNoteState {}
class Error extends AddNewNoteState {
  final String msg;

  Error(this.msg);
}
