import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/appointment_model.dart';

class DatabaseProvider {
// using singleton pattern
  DatabaseProvider._();
  static final DatabaseProvider dbProvider = DatabaseProvider._();

  static Database _db;
  final _dbName = 'papp.db';
  final _appointmentTable = 'Appointment';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDatabase();
      return _db;
    }
  }

  Future<Database> initDatabase() async {
    // set the path to the database
    // Note: Using the `join` function from the `path` package
    // is best practice to ensure the path is correctly constructed for each platform.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);

    // Open the database and store the reference.
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute('''
          CREATE TABLE $_appointmentTable
          (
            id INTEGER PRIMARY KEY,
            category TEXT,
            dateTime TEXT,
            place TEXT,
            supervisor TEXT,
            earnedPappTaler INTEGER,
            subject TEXT
          )
        ''');
      },
    );
    return _db;
  }

  Future<List<AppointmentModel>> fetchAppointments() async {
    final List<Map<String, dynamic>> maps = await _db.query(_appointmentTable);
    if (maps.length == 0) {
      return null;
    }

    return List.generate(
      maps.length,
      (i) => AppointmentModel.fromJson(
        maps[i],
      ),
    );
  }

  Future<AppointmentModel> fetchAppointmentById(int id) async {
    final appointment = await _db.query(
      _appointmentTable,
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    ) as Map<String, dynamic>;

    if (appointment == null) {
      return null;
    }
    return AppointmentModel.fromJson(appointment);
  }

  void insertAppointment(AppointmentModel appointment) {
    _db.insert(
      _appointmentTable,
      appointment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
