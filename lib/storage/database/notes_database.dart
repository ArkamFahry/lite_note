
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''  
      CREATE TABLE ${NoteCollection.notesCollection}(
        ${NoteCollection.id} $idType,
        ${NoteCollection.isImportant} $boolType,
        ${NoteCollection.number} $intType,
        ${NoteCollection.title} $textType,
        ${NoteCollection.description} $textType,
        ${NoteCollection.createdAt} $textType,
        ${NoteCollection.updatedAt} $textType
      )
    ''');
  }
  

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}