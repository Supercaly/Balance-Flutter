// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:balance_app/dao/measurement-dao.dart';
import 'package:balance_app/model/measurement.dart';

part 'moor-database.g.dart';

@Database(version: 1, entities: [Measurement])
abstract class MoorDatabase extends FloorDatabase {
  MeasurementDao get measurementDao;

  static MoorDatabase _dbInstance;

  static Future<MoorDatabase> getDatabase() async {
    if (_dbInstance == null)
      _dbInstance = await $FloorMoorDatabase.databaseBuilder("measurements_database").build();
    return _dbInstance;
  }
}