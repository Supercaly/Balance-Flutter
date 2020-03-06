import 'package:balance_app/dao/measurement_dao.dart';
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiTestInit();

  group("Database Tests", () {
    MeasurementDatabase database;
    MeasurementDao measurementDao;

    setUp(() async {
      database = await $FloorMeasurementDatabase
        .inMemoryDatabaseBuilder()
        .build();
      measurementDao = database.measurementDao;
    });

    tearDown(() async {
      await database.close();
      database = null;
      measurementDao = null;
    });

    test("insert new measurement", () async {
      final newMeas = Measurement(
        id: 1,
        creationDate: DateTime.now().millisecondsSinceEpoch,
        eyesOpen: true
      );
      final int newId = await measurementDao.insertMeasurement(newMeas);

      // The inserted id is the same?
      expect(newId, equals(1));

      // The only item inserted in an empty database is this?
      final allMeas = await measurementDao.getAllMeasurements();
      expect(allMeas, hasLength(1));
      expect(allMeas[0], equals(newMeas));
    });
    
    test("read one measurement", () async {
      final newMeas = Measurement(
        id: 2,
        creationDate: DateTime.now().millisecondsSinceEpoch,
        eyesOpen: false
      );
      await measurementDao.insertMeasurement(newMeas);

      // Return a specific measurement
      final meas = await measurementDao.findMeasurementById(2);
      expect(meas, equals(newMeas));
    });

    test("read all measurement", () async {
      final allMeas = await measurementDao.getAllMeasurements();
      expect(allMeas, isNotNull);
    });
  });
}