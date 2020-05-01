
import 'dart:math' as math;

import 'package:iirjdart/butterworth.dart';

/// Sway Density Analysis
///
/// This function compute the sway density analysis for the given pairs of
/// ap and ml values.
/// First it computes the sway density curve (SDC), defined
/// as the time-dependent curve that counts, for each time instant, the number
/// of consecutive samples of the statokinesigram that fall inside a circle of
/// [radius] radius; the sample count is divided by the sampling rate yielding a
/// time-vs-time curve, then this curve is filtered with a fourth-order Butterworth
/// low-pass filter with a cutoff frequency of 2.5Hz.
/// Once computed the SDC the time instants where the curve reaches a peak are extracted
/// and the indicators are computed.
/// Those indicators are:
/// - NP mean number of SDC peaks per second (unit)
/// - MT mean time interval between successive peaks (seconds)
/// - ST standard deviation of MT (seconds)
/// - MP mean value of peaks (seconds)
/// - SP standard deviation of MP (seconds)
/// - MD mean distance between successive peaks (millimeters)
/// - SD standard deviation of MD (millimeters)
Map<String, double> computeSwayDensityAnalysis(List<double> ap, List<double> ml, double radius) {
  assert(ml.length == ap.length, "ml and ap lists must have same size!");
  assert(radius > 0.0, "radius must be gather than zero!");

  /*
   * For each point create a circle center in that point
   * with the given radius and count how many other points
   * are inside the circle
   */
  // TODO: 04/12/19 Per ora conto anche il punto stesso, devo escluderlo? basta fare -1?
  List<int> sampleCount = List(ml.length);
  for(var j= 0; j < ml.length; j++) {
    int dotsInsideCircle = 0;
    for(var i= 0; i < ml.length; i++) {
      if (math.pow(ml[i] - ml[j], 2) + math.pow(ap[i] - ap[j], 2) <= math.pow(radius, 2))
        dotsInsideCircle++;
    }
    sampleCount[j] = dotsInsideCircle;
  }

  // Divide sample count by the sampling rate
  final sdc = sampleCount.map((e) => e / 50.0);

  // Filter the samples with a 4° order Butterworth low-pass filter with a cutoff frequency of 2.5Hz
  final filter = Butterworth();
  filter.lowPass(4, 50.0, 2.5);
  final filteredSDC = sdc.map((e) => filter.filter(e)).toList();

  // Find all peaks larger than the threshold
  final threshold = 0.001;
  List<int> peaksArr = [];
  for (var i = 1; i < filteredSDC.length; i++) {
    if (filteredSDC[i] - filteredSDC[i - 1] >= threshold &&
      filteredSDC[i] - filteredSDC[i + 1] >= threshold)
      peaksArr.add(i);
  }

  // Compute the nummax feature
  double numMax = peaksArr.length / 30.0;

  // Compute the indicators for every peak
  List<int> timeIntervals = [];
  List<double> valueOfPeaks = [];
  List<double> distances = [];
  for (var i = 0; i < peaksArr.length - 1; i++) {
    timeIntervals.add(peaksArr[i + 1] - peaksArr[i]);
    valueOfPeaks.add(filteredSDC[peaksArr[i]]);
    distances.add(math.sqrt(math.pow((peaksArr[i + 1] - peaksArr[i]).toDouble(), 2) +
      math.pow(filteredSDC[peaksArr[i + 1]] - filteredSDC[peaksArr[i]], 2)));
  }

  // Average the indicators to obtain the SDC Parameters
  double mt = timeIntervals.avg();
  double mp = valueOfPeaks.avg();
  double md = distances.avg();

  // Compute the standard deviation of the indicators
  double st = timeIntervals.std();
  double sp = valueOfPeaks.std();
  double sd = distances.std();

  return {
    "numMax": numMax,
    "meanDistance": md,
    "stdDistance": sd,
    "meanTime": mt,
    "stdTime": st,
    "meanPeaks": mp,
    "stdPeaks": sp,
  };
}

extension _StdDouble on List<double> {
  double avg() => this.fold(0.0, (prev, e) => prev + e) / this.length;

  double std() {
    double mean = this.avg();
    return math.sqrt(
      this.fold(0.0, (prev, e) => prev + (math.pow(e, 2) - math.pow(mean, 2))) / (this.length - 1));
  }
}

extension _StdInt on List<int> {
  double avg() => this.fold(0.0, (prev, e) => prev + e) / this.length;

  double std() {
    double mean = this.avg();
    return math.sqrt(
      this.fold(0, (prev, e) => prev + (math.pow(e, 2) - math.pow(mean, 2))) / (this.length - 1));
  }
}