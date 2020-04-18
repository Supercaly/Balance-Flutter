
import 'package:floor/floor.dart';
import 'package:balance_app/model/raw_measurement_data.dart';

@dao
abstract class RawMeasurementDataDao {
  @Insert(onConflict: OnConflictStrategy.IGNORE)
  Future<List<int>> insertRawMeasurements(List<RawMeasurementData> measData);

  @Query("SELECT * FROM measurements_data WHERE measurement_id = :measurementId")
  Future<List<RawMeasurementData>> findAllRawMeasDataForId(int measurementId);

  @Query("SELECT * FROM measurements_data")
  Future<List<RawMeasurementData>> getAllData();
}