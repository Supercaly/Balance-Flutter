
import 'dart:math' as math;

import 'package:balance_app/model/raw_measurement_data.dart';

Future<Map<String, double>> gyroscopicFeatures(List<RawMeasurementData> data) {
  // TODO: 03/05/20 Put real code here
  return Future.value({
    "grX": null,
    "grY": null,
    "grZ": null,
    "gmX": null,
    "gmY": null,
    "gmZ": null,
    "gvX": null,
    "gvY": null,
    "gvZ": null,
    "gsX": null,
    "gsY": null,
    "gsZ": null,
    "gkX": null,
    "gkY": null,
    "gkZ": null,
  });
  /*List<double> x = [];
  List<double> y = [];
  List<double> z = [];
  for (var d in data) {
    if (d.gyroscopeX != 0)
      x.add(d.gyroscopeX);
    if (d.gyroscopeY != 0)
      y.add(d.gyroscopeY);
    if (d.gyroscopeZ != 0)
      z.add(d.gyroscopeZ);
  }

  double minX = x.reduce(math.min);
  double maxX = x.reduce(math.max);
  double rangeX = maxX - minX;
  double minY = y.reduce(math.min);
  double maxY = y.reduce(math.max);
  double rangeY = maxY - minY;
  double minZ = z.reduce(math.min);
  double maxZ = z.reduce(math.max);
  double rangeZ = maxZ - minZ;

  return Future.value({
    "grX": rangeX,
    "grY": rangeY,
    "grZ": rangeZ,
    "gmX": maxX,
    "gmY": maxY,
    "gmZ": maxZ,
  });*/
}