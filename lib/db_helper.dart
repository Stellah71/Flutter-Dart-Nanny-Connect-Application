import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;
  
  // Create and open the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'nanny_connect.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(
        'CREATE TABLE employers(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
      );
      db.execute(
        'CREATE TABLE nannies(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, experience TEXT)',
      );
    }, version: 1);
  }

  // Insert a new employer
  Future<void> insertEmployer(Map<String, dynamic> employer) async {
    final db = await database;
    await db.insert('employers', employer, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Insert a new nanny
  Future<void> insertNanny(Map<String, dynamic> nanny) async {
    final db = await database;
    await db.insert('nannies', nanny, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get an employer by email
  Future<Map<String, dynamic>?> getEmployerByEmail(String email) async {
    final db = await database;
    var result = await db.query('employers', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty ? result.first : null;
  }

  // Get all nannies
  Future<List<Map<String, dynamic>>> getAllNannies() async {
    final db = await database;
    return await db.query('nannies');
  }
}
