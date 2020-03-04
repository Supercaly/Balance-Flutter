
import 'package:balance_app/model/measurement.dart';

class MeasurementsRepository {

  Future<List<Measurement>> getMeasurements() {
    return Future.value([
      Measurement(1, "02-03-2020 20:20:20", true),
      Measurement(2, "02-03-1919 20:20:20", false),
      Measurement(3, "02-03-2020 20:20:20", true),
      Measurement(4, "02-05-2019 20:20:20", false),
    ]);
  }
}