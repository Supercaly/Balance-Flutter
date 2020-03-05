import 'package:balance_app/moor/moor-database.dart';

/// Repository class for retrieving all the old measurements
///
/// This class implements a Repository in the Design Pattern Bloc
/// and has the purpose of returning all the [Measurement] objects
/// wherever they are needed
class MeasurementsRepository {
  final MoorDatabase database;

  MeasurementsRepository(this.database);

  /// Return all the old measurements
  Future<List<Measurement>> getMeasurements() {
    return database.measurementDao.getAllMeasurements();
  }
}