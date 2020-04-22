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

  group("DatabaseView Tests", () {
    MeasurementDatabase database;
    MeasurementDao measurementDao;
    List<Measurement> prePopulatedData = [
      Measurement(creationDate: 1, eyesOpen: true),
      Measurement(creationDate: 2, eyesOpen: false),
    ];

    setUp(() async{
      database = await $FloorMeasurementDatabase
        .inMemoryDatabaseBuilder()
        .build();
      measurementDao = database.measurementDao;

      for(var m in prePopulatedData)
        await measurementDao.insertMeasurement(m);
    });

    tearDown(() async{
      await database.close();
      database = null;
      measurementDao = null;
    });

    test("find test by id", () async{
      final originalMeas = await measurementDao.findMeasurementById(1);
      final test = await measurementDao.findTestById(1);
      expect(originalMeas.id, equals(test.id));
      expect(originalMeas.creationDate, equals(test.creationDate));
      expect(originalMeas.eyesOpen, equals(test.eyesOpen));

      final originalMeas2 = await measurementDao.findMeasurementById(2);
      final test2 = await measurementDao.findTestById(2);
      expect(originalMeas2.id, equals(test2.id));
      expect(originalMeas2.creationDate, equals(test2.creationDate));
      expect(originalMeas2.eyesOpen, equals(test2.eyesOpen));
    });

    test("get all tests", () async{
      final allTest = await measurementDao.getAllTests();

      expect(allTest, hasLength(2));
      expect(allTest[0].id, equals(1));
      expect(allTest[0].creationDate, equals(prePopulatedData[0].creationDate));
      expect(allTest[0].eyesOpen, equals(prePopulatedData[0].eyesOpen));
      expect(allTest[1].id, equals(2));
      expect(allTest[1].creationDate, equals(prePopulatedData[1].creationDate));
      expect(allTest[1].eyesOpen, equals(prePopulatedData[1].eyesOpen));

    });
  });
}