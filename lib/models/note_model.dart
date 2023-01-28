import 'package:intl/intl.dart';

class NoteModel {
  static const String table = "notes";
  static const String colNoteId = "noteId";
  static const String colTitle = "title";
  static const String colDescription = "description";
  static const String colIsActive = "isActive";
  static const String colAddedOn = "addedOn";

  static const String createTable = '''
  CREATE TABLE $table (
          $colNoteId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colTitle TEXT NULL,
          $colDescription TEXT NULL,
          $colIsActive INTEGER NOT NULL,
          $colAddedOn INTEGER NOT NULL
  )''';

  int? noteId;
  String? title;
  String? description;
  bool? isActive;
  int? addedOn;
  String getFDate() => DateFormat('dd/MM/yy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(addedOn!));
  NoteModel(
      {this.noteId, this.title, this.description, this.isActive, this.addedOn});

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'description': description,
      'isActive': isActive! ?1:0,
      'addedOn': addedOn,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      noteId: map['noteId'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      isActive: map['isActive']==1,
      addedOn: map['addedOn'] as int,
    );
  }

}
