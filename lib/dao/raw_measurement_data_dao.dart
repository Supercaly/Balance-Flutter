
import 'package:balance_app/model/raw_measurement.dart';
import 'package:floor/floor.dart';

@dao
abstract class RawMeasurementDataDao {
  @Insert(onConflict: OnConflictStrategy.IGNORE)
  Future<List<int>> insertRawMeasurements(List<RawMeasurement> measData);

  @Query("SELECT * FROM measurements_data WHERE measurement_id = :measurementId")
  Future<List<RawMeasurement>> findAllRawMeasDataForId(int measurementId);

  @Query("SELECT * FROM measurements_data")
  Future<List<RawMeasurement>> getAllData();
}