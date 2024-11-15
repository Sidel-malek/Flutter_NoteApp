import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Note.dart';  // Importer la classe Note

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'notes.db');  // Nom de la base de données

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE notes ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '  // ID auto-incrémenté
              'title TEXT, '  // Champ pour le titre
              'content TEXT, '  // Champ pour le contenu
              'dateTime TEXT'  // Champ pour la date et l'heure
              ')',
        );
      },
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final result = await db.query('notes');  // Récupérer toutes les notes
    return result.map((json) => Note.fromMap(json)).toList();  // Convertir en liste de Notes
  }

  Future<int> addNote(Note note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());  // Ajouter une note
  }

  Future<int> deleteNoteById(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);  // Supprimer une note par ID
  }

  // Ajoutez la méthode d'initialisation de la base de données ici
  Future<void> initDatabase() async {
    await _initDatabase();
  }
}