part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}
class LoadingNotes extends NotesState {}
class NoNotesFound extends NotesState {}
class Error extends NotesState {
  final String msg;

  Error(this.msg);
}
class ReceivedNotes extends NotesState {
  final List<NoteModel> notes;

  ReceivedNotes(this.notes);
}
