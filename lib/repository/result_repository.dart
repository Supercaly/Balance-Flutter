
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/model/statokinesigram.dart';
import 'package:balance_app/posture_processor/posture_processor.dart';

/// Repository of the result screen
class ResultRepository {
  final MeasurementDatabase database;

  ResultRepository(this.database);

  /// Return a [Statokinesigram] from the stored data
  ///
  /// If the stored [Measurement] doesn't have any features
  /// we compute them using [PostureProcessor], store them
  /// and then return those.
  Future<Statokinesigram> getResult(int measurementId) async {
    if (measurementId == null)
      return Future.error(ArgumentError("measurementId must be non null"));

    // 1. Get the Measurement with the given id
    final measurement = await database.measurementDao.findMeasurementById(measurementId);
    // 2. Check if the features are present and compute them if not
    if (!measurement.hasFeatures) {
      final rawMeasurementData = await database.rawMeasurementDataDao.findAllRawMeasDataForId(measurementId);
      Statokinesigram computed;
      try {
        computed = await PostureProcessor.computeFromData(measurementId, rawMeasurementData);
      } catch(e) {
        print("Error computing $e");
      }
      // Update the measurement with the computed features
      database.measurementDao.updateMeasurement(
        Measurement(
          id: measurement.id,
          creationDate: measurement.creationDate,
          eyesOpen: measurement.eyesOpen,
          swayPath: computed.swayPath,
          meanDisplacement: computed.meanDisplacement,
          stdDisplacement: computed.stdDisplacement,
          minDist: computed.minDist,
          maxDist: computed.maxDist,
          meanFrequencyML: computed.meanFrequencyML,
          meanFrequencyAP: computed.meanFrequencyAP,
          frequencyPeakML: computed.frequencyPeakML,
          frequencyPeakAP: computed.frequencyPeakAP,
          f80ML: computed.f80ML,
          f80AP: computed.f80AP,
          np: computed.np,
          meanTime: computed.meanTime,
          stdTime: computed.stdTime,
          meanPeaks: computed.meanPeaks,
          stdPeaks: computed.stdPeaks,
          meanDistance: computed.meanDistance,
          stdDistance: computed.stdDistance,
          grX: computed.grX,
          grY: computed.grY,
          grZ: computed.grZ,
          gmX: computed.gmX,
          gmY: computed.gmY,
          gmZ: computed.gmZ,
          gvX: computed.gvX,
          gvY: computed.gvY,
          gvZ: computed.gvZ,
          gsX: computed.gsX,
          gsY: computed.gsY,
          gsZ: computed.gsZ,
          gkX: computed.gkX,
          gkY: computed.gkY,
          gkZ: computed.gkZ,
        )
      );
      // Store the computed CogvData
      database.cogvDataDao.insertCogvData(computed.cogv);
      return computed;
    }
    // 3. Return a Statokinesigram with the features
    return Statokinesigram(
      cogv: await database.cogvDataDao.findAllCogvDataForId(measurementId),
      swayPath: measurement.swayPath,
      meanDisplacement: measurement.meanDisplacement,
      stdDisplacement: measurement.stdDisplacement,
      minDist: measurement.minDist,
      maxDist: measurement.maxDist,
      meanFrequencyAP: measurement.meanFrequencyAP,
      meanFrequencyML: measurement.meanFrequencyML,
      frequencyPeakAP: measurement.frequencyPeakAP,
      frequencyPeakML: measurement.frequencyPeakML,
      f80AP: measurement.f80AP,
      f80ML: measurement.f80ML,
      np: measurement.np,
      meanTime: measurement.stdTime,
      stdTime: measurement.stdTime,
      meanDistance: measurement.meanDistance,
      stdDistance: measurement.stdDistance,
      meanPeaks: measurement.meanPeaks,
      stdPeaks: measurement.stdPeaks,
      grX: measurement.grX,
      grY: measurement.grY,
      grZ: measurement.grZ,
      gmX: measurement.gmX,
      gmY: measurement.gmY,
      gmZ: measurement.gmZ,
      gvX: measurement.gvX,
      gvY: measurement.gvY,
      gvZ: measurement.gvZ,
      gsX: measurement.gsX,
      gsY: measurement.gsY,
      gsZ: measurement.gsZ,
      gkX: measurement.gkX,
      gkY: measurement.gkY,
      gkZ: measurement.gkZ,
    );
  }
}