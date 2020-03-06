// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:balance_app/dao/measurement_dao.dart';
import 'package:balance_app/model/measurement.dart';

part 'measurement_database.g.dart';

/// Measurement Floor Database implementation
@Database(version: 1, entities: [Measurement])
abstract class MeasurementDatabase extends FloorDatabase {
  /// Getter for the [MeasurementDao]
  MeasurementDao get measurementDao;

  /// Singleton pattern to instantiate the database
  static MeasurementDatabase _dbInstance;
  static Future<MeasurementDatabase> getDatabase() async {
    if (_dbInstance == null)
      _dbInstance = await $FloorMeasurementDatabase
        .databaseBuilder("measurements_database")
        .build();
    return _dbInstance;
  }
}