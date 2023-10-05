import 'package:lite_note/storage/models/note.dart';

import '../database/notes_database.dart';

class NotesRepository {
  static final NotesRepository instance = NotesRepository._init();

  NotesRepository._init();

  Future<Note> createNote(Note note) async {
    final db = await NotesDatabase.instance.database;

    final id = await db.insert(NoteCollection.notesCollection, note.toJson());

    return note.copy(id: id);
  }

  Future<int> updateNote(Note note) async {
    final db = await NotesDatabase.instance.database;

    return await db.update(
      NoteCollection.notesCollection,
      note.toJson(),
      where: '${NoteCollection.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await NotesDatabase.instance.database;

    return await db.delete(
      NoteCollection.notesCollection,
      where: '${NoteCollection.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Note> getNote(int id) async {
    final db = await NotesDatabase.instance.database;

    final maps = await db.query(
      NoteCollection.notesCollection,
      columns: NoteCollection.fields,
      where: '${NoteCollection.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> getAllNotes() async {
    final db = await NotesDatabase.instance.database;

    final maps = await db.query(NoteCollection.notesCollection);

    return maps.map((map) => Note.fromJson(map)).toList();
  }
}