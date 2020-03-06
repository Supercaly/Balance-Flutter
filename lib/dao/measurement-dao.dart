import 'package:balance_app/model/measurement.dart';
import 'package:floor/floor.dart';

/// DAO class declaring the database operations for [Measurement]
@dao
abstract class MeasurementDao {

  /// Insert a new [Measurement] into the database
  @Insert(onConflict: OnConflictStrategy.IGNORE)
  Future<int> insertMeasurement(Measurement measurement);

  /// Returns a [Future] with a [List] of all the [Measurement]s inside the database
  @Query("SELECT * FROM measurements")
  Future<List<Measurement>> getAllMeasurements();

//  @Query("SELECT * FROM measurements")
//  /// Returns a [Stream] with a [List] of all the [Measurement]s inside the database
//  Stream<List<Measurement>> watchAllMeasurements();

  /// Returns a specific [Measurement] based on the given [id]
  @Query("SELECT * FROM measurements WHERE id = :id")
  Future<Measurement> findMeasurementById(int id);

}