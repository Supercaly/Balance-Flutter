
import 'package:balance_app/dao/measurement_dao.dart';
import 'package:balance_app/dao/raw_measurement_data_dao.dart';
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/model/raw_measurement.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiTestInit();

  group("Database Tests", () {
    MeasurementDatabase database;
    RawMeasurementDataDao rawMeasurementDataDao;
    MeasurementDao measurementDao;
    List<Measurement> measurements = [
      Measurement(id: 1, creationDate: 1, eyesOpen: false),
      Measurement(id: 2, creationDate: 1, eyesOpen: false),
      Measurement(id: 3, creationDate: 1, eyesOpen: false),
    ];
    List<RawMeasurement> rawMeasurementsList = [
      RawMeasurement(id: 0, measurementId: 1),
      RawMeasurement(id: 1, measurementId: 1),
      RawMeasurement(id: 2, measurementId: 1),
      RawMeasurement(id: 3, measurementId: 2),
      RawMeasurement(id: 4, measurementId: 2),
      RawMeasurement(id: 5, measurementId: 3),
    ];

    setUp(() async {
      database = await $FloorMeasurementDatabase
        .inMemoryDatabaseBuilder()
        .build();
      measurementDao = database.measurementDao;
      rawMeasurementDataDao = database.rawMeasurementDataDao;

      // Pre-insert the measurements in the db
      for (var meas in measurements)
        await measurementDao.insertMeasurement(meas);
    });

    tearDown(() async {
      await database.close();
      database = null;
      rawMeasurementDataDao = null;
    });

    test("insert new raw measurement data", () async {
      final newIds = await rawMeasurementDataDao
        .insertRawMeasurements(rawMeasurementsList);

      final allData = await rawMeasurementDataDao.getAllData();
      // All the items are inserted?
      expect(newIds, hasLength(6));
      expect(allData, hasLength(6));
    });
    
    test("read data for a given measurement", () async {
      await rawMeasurementDataDao.insertRawMeasurements(rawMeasurementsList);

      // Find the all the data related to a measurement
      final firstData = await rawMeasurementDataDao.findAllRawMeasDataForId(1);
      expect(firstData, hasLength(3));
      final secondData = await rawMeasurementDataDao.findAllRawMeasDataForId(2);
      expect(secondData, hasLength(2));
      final thirdData = await rawMeasurementDataDao.findAllRawMeasDataForId(3);
      expect(thirdData, hasLength(1));
    });

    test("read all raw measurements", () async {
      await rawMeasurementDataDao.insertRawMeasurements(rawMeasurementsList);

      // Find the all the data
      final allData = await rawMeasurementDataDao.getAllData();
      expect(allData, hasLength(6));
      expect(allData, equals(rawMeasurementsList));
    });
  });
}