
import 'package:balance_app/manager/preference_manager.dart';
import 'package:balance_app/model/statokinesigram.dart';
import 'package:balance_app/posture_processor/cogv_processor.dart';
import 'package:balance_app/posture_processor/src/sway_density_analysis.dart';
import 'package:balance_app/posture_processor/src/time_domain_features.dart';
import 'package:flutter/foundation.dart';
import 'package:balance_app/model/raw_measurement_data.dart';

class PostureProcessor {
    static const double _defaultHeight = 165.0;
  /// Factor of conversion used to obtain d from the user height in cm
  static const double _heightConversionFactor = 0.530 * 10;

  static Future<Statokinesigram> computeFromData(List<RawMeasurementData> data) async{
    double userHeight = (await PreferenceManager.userInfo).height;
    return compute(_computeFromDataImpl, {"data": data, "height": userHeight});
  }

  static Future<Statokinesigram> _computeFromDataImpl(Map<String, Object> args) async{
    final double dFactor = ((args["height"] ?? _defaultHeight) as double) * _heightConversionFactor;
    final List<RawMeasurementData> data = args["data"];

    await computeCogv(data, dFactor);

    final List<double> cogvAp = droppedDataList[0];
    final List<double> cogvMl = droppedDataList[1];

    // Compute the time domain features
    Map tdf = await timeDomainFeatures(cogvAp, cogvMl);
    // Compute the frequency domain features
    // Compute the structural features
    Map sf = await swayDensityAnalysis(cogvAp, cogvMl, 0.02);
    // Compute the gyroscopic features

    return Statokinesigram(
      swayPath: tdf["swayPath"],
      meanDisplacement: tdf["meanDisplacement"],
      stdDisplacement: tdf["stdDisplacement"],
      minDist: tdf["minDist"],
      maxDist: tdf["maxDist"],
      np: sf["numMax"],
      meanTime: sf["meanTime"],
      stdTime: sf["stdTime"],
      meanDistance: sf["meanDistance"],
      stdDistance: tdf["stdDistance"],
      meanPeaks: sf["meanPeaks"],
      stdPeaks: sf["stdPeaks"],
    );
  }
}