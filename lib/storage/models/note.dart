class NoteCollection {
  static const String notesCollection = 'notes_collection';
  static const List<String> fields = [
    id, isImportant, number, title, description, createdAt, updatedAt
  ];

  static const String id = 'id';
  static const String isImportant = 'is_important';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, Object?> toJson() => {
        NoteCollection.id: id,
        NoteCollection.isImportant: isImportant ? 1 : 0,
        NoteCollection.number: number,
        NoteCollection.title: title,
        NoteCollection.description: description,
        NoteCollection.createdAt: createdAt.toIso8601String(),
        NoteCollection.updatedAt: updatedAt.toIso8601String(),
  };

  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteCollection.id] as int?,
    isImportant: json[NoteCollection.isImportant] == 1,
    number: json[NoteCollection.number] as int,
    title: json[NoteCollection.title] as String,
    description: json[NoteCollection.description] as String,
    createdAt: DateTime.parse(json[NoteCollection.createdAt] as String),
    updatedAt: DateTime.parse(json[NoteCollection.updatedAt] as String),
  );

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Note(
    id: id ?? this.id,
    isImportant: isImportant ?? this.isImportant,
    number: number ?? this.number,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}