
import 'dart:math' as math;

import 'package:balance_app/model/raw_measurement_data.dart';
import 'package:balance_app/posture_processor/src/math/matrix.dart';
import 'package:balance_app/posture_processor/src/math/vactor3.dart';
import 'package:flutter/material.dart';
import 'package:iirjdart/butterworth.dart';

/// Value of the g force
const double _gForce = 9.807;
/// Factor of conversion used to obtain d from the user height in cm
const double _heightConversionFactor = 0.530 * 10;

Future<Matrix> computeCogv(List<RawMeasurementData> data, double height) {
  // The algorithm for computing the COGv data is divided in 5 steps:
  // Step 1. Map the data from RawMeasurementData
  final accXWithG = data.map((e) => e.accelerometerX / _gForce).toList();
  final accYWithG = data.map((e) => e.accelerometerY / _gForce).toList();
  final accZWithG = data.map((e) => e.accelerometerZ / _gForce).toList();
  // Step 2. Rotate the axis
  final rotatedData = rotateAxis(accXWithG, accYWithG, accZWithG);
  // Step 3. Filter the data
  final filteredData = filterData(rotatedData * (height * _heightConversionFactor));
  // Step 4. Down-sample and drop first two seconds
  final droppedData = removeFirstTwoSecond(detrend(downsample(filteredData)));

  return Future.value(droppedData);
}

/// Method that rotate the axis till the y component is parallel to the gravity
///
/// The rotation serves to neutralize any non-vertical positioning of the smartphone; the idea
/// is to rotate the axis until the y mean component is maxed and the other two are at the minimum;
/// the y axes is parallel to the gravity force and can be dropped because it's no more needed.
///
/// Here is the algorithm written in Octave code:
/// <p>
///     meanX = mean(AccXd);
///     meanY = mean(AccYd);
///     meanZ = mean(AccZd);
///
///     p0 = [meanX;meanZ;meanY]; % smartphone gravity vector components
///     p1 = [0;0;1];             % plane gravity vector components
///
///     C = cross(p0, p1);
///     D = dot(p0, p1);
///     NP0 = norm(p0)
///
///     % Create the rotation matrix
///     if ~all(C==0)
///     Z = [0 -C(3) C(2); C(3) 0 -C(1); -C(2) C(1) 0] ;
///     R = (eye(3) + Z + Z^2 * (1-D)/(norm(C)^2)) / NP0^2 ;
///     else
///     R = sign(D) * (norm(p1) / NP0) ;
///     end
///     originalData = [AccXd,AccZd,AccYd];
///     rotatedData = R*originalData';
///     rotatedData = rotatedData';
///
///     AP = rotatedData(:,2,1);
///     ML = rotatedData(:,1,1);
/// </p>
@visibleForTesting
Matrix rotateAxis(List<double> accX, List<double> accY, List<double> accZ) {
  assert(accX.length == accZ.length && accX.length == accY.length,
  "You must pass 3 lists with equal size!");

  // Compute the average values for x, y, z
  final meanX = accX.reduce((a, b) => a + b) / accX.length;
  final meanY = accY.reduce((a, b) => a + b) / accY.length;
  final meanZ = accZ.reduce((a, b) => a + b) / accZ.length;

  final dataMatrix = matrix3xMOf(accX, accZ, accY);

  // Create gravity vectors for mean data and for the plane
  final p0 = Vector3.of(meanX, meanZ, meanY);
  final p1 = Vector3.of(0.0, 0.0, 1.0);
  final crossVector = p0.cross(p1);
  final dot = p0.dot(p1);
  final p0Norm = p0.norm();

  // Create the rotation matrix
  Matrix rotatedDataMatrix;
  if (!crossVector.all((double) => double == 0.0)) {
    final zMatrix = matrix3x3Of([
      0.0, -crossVector[2], crossVector[1],
      crossVector[2], 0.0, -crossVector[0],
      -crossVector[1], crossVector[0], 0.0
    ]);

    final rMatrix = (Matrix.identity(3) + zMatrix + matrix3x3pow2(zMatrix) *
      ((1 - dot) / math.pow(crossVector.norm(), 2))) / math.pow(p0Norm, 2);
    rotatedDataMatrix = rMatrix.times(dataMatrix);
  } else {
    double sign = dot != 0
      ? (dot.isNegative? -1.0: 1.0)
      : 0.0;
    final rDouble = sign * (p1.norm() / p0Norm);
    rotatedDataMatrix = dataMatrix * rDouble;
  }

  // Drop the y axes
  return Matrix.generate(2, rotatedDataMatrix.cols,
      (row, col) => rotatedDataMatrix.get(row, col)
  );
}

/// Apply a low-pass filter to the given data
///
/// This method applies a 4th order Butterworth low-pass
/// filter with a cutoff frequency of 1Hz to the two
/// coordinates separately.
@visibleForTesting
Matrix filterData(Matrix dataToFilter) {
  final butterworthX = Butterworth();
  butterworthX.lowPass(4, 100.0, 1.0);
  final butterworthZ = Butterworth();
  butterworthZ.lowPass(4, 100.0, 1.0);

  return dataToFilter.mapIndexed((row, _, value) {
    if (row == 0)
      return butterworthX.filter(value);
    return butterworthZ.filter(value);
  });
}

/// Downsample the data to 50Hz
///
/// Given list of data sampled at 100Hz this method will downsample
/// it to 50Hz, this is achieved by simply removing one sample every
/// two, so the final size is half the original.
@visibleForTesting
Matrix downsample(Matrix dataToDownsample) {
  final List<double> downsampledXList = [];
  final List<double> downsampledZList = [];
  dataToDownsample.forEachColumn((col, values) {
    if (col % 2 == 0) {
      downsampledXList.add(values[0]);
      downsampledZList.add(values[1]);
    }
  });

  return matrix2xMOf(downsampledXList, downsampledZList);
}

/// Detrend the data
///
/// The given data are detrended by removing the
/// average values from each one.
/// The matrix is divided in two lists (Ml ans Ap),
/// each one is averaged and that average is subtracted
/// from each value.
@visibleForTesting
Matrix detrend(Matrix dataToDetrend) {
  // Compute the average of COGvAP and COGvML
  var xMean = 0.0;
  var zMean = 0.0;
  dataToDetrend.forEachColumn((_, values) {
    xMean += values[0];
    zMean += values[1];
  });
  xMean /= dataToDetrend.cols;
  zMean /= dataToDetrend.cols;

  final List<double> xVals = [];
  final List<double> zVals = [];
  dataToDetrend.forEachIndexed((row, _, value) {
    if (row == 0)
      xVals.add(value - xMean);
    else
      zVals.add(value - zMean);
  });
  return matrix2xMOf(xVals, zVals);
}

/// Remove the first two seconds of data from the matrix
///
/// Remove the first two seconds of data from the given matrix, with
/// a sampling rate of 50Hz that means removing 100 samples to each axes.
@visibleForTesting
Matrix removeFirstTwoSecond(Matrix dataToDrop) {
  final List<List<double>> rows = dataToDrop.extractRows();
  return matrix2xMOf(
    rows[0].skip(100).toList(),
    rows[1].skip(100).toList(),
  );
}