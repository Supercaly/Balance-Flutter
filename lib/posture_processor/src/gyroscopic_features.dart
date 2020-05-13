
import 'dart:math';

import 'package:balance_app/model/raw_measurement_data.dart';
import 'package:balance_app/posture_processor/src/list_extension.dart';

Future<Map<String, double>> gyroscopicFeatures(List<RawMeasurementData> data) {
  // Extract x,y,z from RawMeasurementData
  data.removeWhere((e) => e.gyroscopeX == null || e.gyroscopeY == null || e.gyroscopeZ == null);
  final x = data.map((e) => e.gyroscopeX).toList();
  final y = data.map((e) => e.gyroscopeY).toList();
  final z = data.map((e) => e.gyroscopeZ).toList();

  // Get max value of x,y,z
  final gmX = x.reduce(max);
  final gmY = y.reduce(max);
  final gmZ = z.reduce(max);

  // Get range value of x,y,z
  final grX = gmX - x.reduce(min);
  final grY = gmY - y.reduce(min);
  final grZ = gmZ - z.reduce(min);

  // Get variance of x,y,z
  final gvX = x.variance();
  final gvY = y.variance();
  final gvZ = z.variance();

  // Get kurtosis index of x,y,z
  final gkX = x.kurtosisIndex();
  final gkY = y.kurtosisIndex();
  final gkZ = z.kurtosisIndex();

  // Get skewness index of x,y,z
  final gsX = x.skewnessIndex();
  final gsY = y.skewnessIndex();
  final gsZ = z.skewnessIndex();

  // TODO: 03/05/20 Put real code here
  return Future.value({
    "grX": grX,
    "grY": grY,
    "grZ": grZ,
    "gmX": gmX,
    "gmY": gmY,
    "gmZ": gmZ,
    "gvX": gvX,
    "gvY": gvY,
    "gvZ": gvZ,
    "gsX": gsX,
    "gsY": gsY,
    "gsZ": gsZ,
    "gkX": gkX,
    "gkY": gkY,
    "gkZ": gkZ,
  });
}