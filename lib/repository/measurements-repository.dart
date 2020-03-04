import 'package:balance_app/model/measurement.dart';

/// Repository class for retrieving all the old measurements
///
/// This class implements a Repository in the Design Pattern Bloc
/// and has the purpose of returning all the [Measurement] objects
/// wherever they are needed
class MeasurementsRepository {

  /// Return all the old measurements
  Future<List<Measurement>> getMeasurements() {
    // TODO: 04/03/20 Convert this to a call to the database with real data
    return Future.value([
      Measurement(1, "02-03-2020 20:20:20", true),
      Measurement(2, "02-03-1919 20:20:20", false),
      Measurement(3, "02-03-2020 20:20:20", true),
      Measurement(4, "02-05-2019 20:20:20", false),
    ]);
  }
}