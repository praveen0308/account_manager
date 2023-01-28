import 'package:account_manager/models/note_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../repository/note_repository.dart';

part 'add_new_note_state.dart';

class AddNewNoteCubit extends Cubit<AddNewNoteState> {

  final NoteRepository _noteRepository;
  AddNewNoteCubit(this._noteRepository) : super(AddNewNoteInitial());
  void addNewNote(NoteModel note) async {
    emit(AddingNote());

    try{
      note.isActive = true;
      note.addedOn = DateTime.now().millisecondsSinceEpoch;
      var result = await _noteRepository
          .addNewNote(note);
      if(result) {
        emit(AddedSuccessfully());
      } else {
        emit(Error("Failed!!!"));
      }
    }catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }
  }

  void draftNote(NoteModel note) async {
    emit(AddingNote());

    try{
      note.isActive = false;
      note.addedOn = DateTime.now().millisecondsSinceEpoch;
      var result = await _noteRepository
          .addNewNote(note);
      if(result) {
        emit(AddedSuccessfully());
      } else {
        emit(Error("Failed!!!"));
      }
    }catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }
  }

  void updateNote(NoteModel note) async {
    emit(AddingNote());

    try{
      note.isActive = true;
      var result = await _noteRepository
          .updateNote(note);
      if(result) {
        emit(AddedSuccessfully());
      } else {
        emit(Error("Failed!!!"));
      }
    }catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }
  }


}
