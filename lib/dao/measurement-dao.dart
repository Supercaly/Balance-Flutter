import 'package:balance_app/moor/moor-database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'measurement-dao.g.dart';

/// DAO class declaring the database operations for [Measurement]
@UseDao(tables: [Measurement])
class MeasurementDao extends DatabaseAccessor<MoorDatabase> with _$MeasurementDaoMixin {
  MeasurementDao(MoorDatabase db): super(db);

  /// Returns a [Future] with a [List] of all the [Measurement]s inside the database
  Future<List<Measurement>> getAllMeasurements() => select(db.measurements).get();

  /// Returns a [Stream] with a [List] of all the [Measurement]s inside the database
  Stream<List<Measurement>> watchAllMeasurements() => select(db.measurements).watch();

  /// Insert a new [Measurement] into the database
  Future<int> insertMeasurement(Insertable<Measurement> measurement) => into(db.measurements).insert(measurement);

  /// Returns a specific [Measurement] based on the given [id]
  Future<Measurement> findMeasurementById(int id) => Future.value(null);

}