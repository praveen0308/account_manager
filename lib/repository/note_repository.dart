import 'package:account_manager/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../local/db_helper.dart';

class NoteRepository{
  final dbHelper = DatabaseHelper.instance;
  Future<bool> draftNewNote(NoteModel note) async {
    Database db = await dbHelper.database;
    var result = await db.insert(NoteModel.table, note.toMap());
    return result > 0;
  }

  Future<bool> addNewNote(NoteModel note) async {
    Database db = await dbHelper.database;
    var result = await db.insert(NoteModel.table, note.toMap());
    return result > 0;
  }

  Future<bool> updateNote(NoteModel note) async {
    Database db = await dbHelper.database;
    var rows = note.toMap();
    rows.remove(NoteModel.colNoteId);
    var result = await db.update(NoteModel.table, rows,where: "${NoteModel.colNoteId}=?",whereArgs: [note.noteId]);
    return result > 0;
  }

  Future<bool> deleteNote(int noteId) async {
    Database db = await dbHelper.database;

    var result = await db.delete(NoteModel.table, where: "${NoteModel.colNoteId}=?",whereArgs: [noteId]);
    return result > 0;
  }

  Future<List<NoteModel>> getAllNotes() async {
    Database db = await dbHelper.database;
    var records = await db.query(NoteModel.table);

    return records.map((e) => NoteModel.fromMap(e)).toList();
  }

}