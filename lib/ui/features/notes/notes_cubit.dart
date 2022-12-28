import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../models/note_model.dart';
import '../../../repository/note_repository.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NoteRepository _noteRepository;
  NotesCubit(this._noteRepository) : super(NotesInitial());


  Future<void> fetchNotes() async {
    emit(LoadingNotes());
    try{

      var result = await _noteRepository.getAllNotes();

      if(result.isNotEmpty){

        emit(ReceivedNotes(result));
      }else{
        emit(NoNotesFound());
      }


    }on Exception catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }

  }

  Future<void> deleteNote(int noteId) async {
    emit(LoadingNotes());
    try{
      await _noteRepository.deleteNote(noteId);
      fetchNotes();
    }on Exception catch(e){
      emit(Error("Something went wrong!!!"));
      debugPrint(e.toString());
    }

  }
}
