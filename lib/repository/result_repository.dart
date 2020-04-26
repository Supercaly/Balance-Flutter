
import 'dart:math';

import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/cogv_data.dart';
import 'package:balance_app/model/statokinesigram.dart';

/// Repository of the result screen
class ResultRepository {
  final MeasurementDatabase database;

  ResultRepository(this.database);

  /// Computes the statokinesigram from a [measurementId]
  Future<Statokinesigram> getResult(int measurementId) async {
    if (measurementId == null)
      return Future.error(ArgumentError("measurementId must be non null"));

    // 1. Get the Measurement with the given id
    final measurement = await database.measurementDao.findMeasurementById(measurementId);
    // 2. Check if the features are present and compute them if not
    if (!measurement.hasFeatures) {
      print("Computing the features...");
    }
    // 3. Return a Statokinesigram with the features
    return Future.delayed(Duration(seconds: 4), () {
      // TODO: 24/04/20 Return a non random Statokinesigram
      final random = Random();
      return Statokinesigram(
        cogv: List.generate(50, (index) => CogvData(ap: random.nextDouble(), ml: random.nextDouble())),
        f80AP: random.nextDouble(),
        f80ML: random.nextDouble(),
        frequencyPeakAP: random.nextDouble(),
        frequencyPeakML: random.nextDouble(),
        gkX: random.nextDouble(),
        gkY: random.nextDouble(),
        gkZ: random.nextDouble(),
        gmX: random.nextDouble(),
        gmY: random.nextDouble(),
        gmZ: random.nextDouble(),
        grX: random.nextDouble(),
        grY: random.nextDouble(),
        grZ: random.nextDouble(),
        gsX: random.nextDouble(),
        gsY: random.nextDouble(),
        gsZ: random.nextDouble(),
        gvX: random.nextDouble(),
        gvY: random.nextDouble(),
        gvZ: random.nextDouble(),
        maxDist: random.nextDouble(),
        meanDisplacement: random.nextDouble(),
        meanDistance: random.nextDouble(),
        meanFrequencyAP: random.nextDouble(),
        meanFrequencyML: random.nextDouble(),
        meanPeaks: random.nextDouble(),
        meanTime: random.nextDouble(),
        minDist: random.nextDouble(),
        np: random.nextDouble(),
        stdDisplacement: random.nextDouble(),
        stdDistance: random.nextDouble(),
        stdPeaks: random.nextDouble(),
        stdTime: random.nextDouble(),
        swayPath: random.nextDouble(),
      );
    });
  }
}