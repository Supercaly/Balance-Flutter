
import 'dart:io';

import 'package:balance_app/posture_processor/math/matrix.dart';
import 'package:balance_app/posture_processor/posture_processor.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group("COGv Processor", () {
    Matrix testDataMatrix;
    // Data to test
    Matrix dataToRotate;
    Matrix dataToFilter;
    Matrix dataToDownsample;
    Matrix dataToDetrend;
    Matrix dataToDrop;
    // Data precomputed
    Matrix rotatedData;
    Matrix filteredData;
    Matrix downsampledData;
    Matrix detrendedData;
    Matrix droppedData;

    setUpAll(() {
      // Get test data from file
      testDataMatrix = loadMatrixFromResource("test_data.txt");

      dataToRotate = loadMatrixFromResource("data_to_rotate.txt")?.transpose();
      dataToFilter = loadMatrixFromResource("data_to_filter.txt")?.transpose();
      dataToDownsample = loadMatrixFromResource("data_to_downsample.txt")?.transpose();
      dataToDetrend = loadMatrixFromResource("data_to_detrend.txt")?.transpose();
      dataToDrop = loadMatrixFromResource("data_to_drop.txt")?.transpose();

      rotatedData = loadMatrixFromResource("rotated_data.txt")?.transpose();
      filteredData = loadMatrixFromResource("filtered_data.txt")?.transpose();
      downsampledData = loadMatrixFromResource("downsampled_data.txt")?.transpose();
      detrendedData = loadMatrixFromResource("detrended_data.txt")?.transpose();
      droppedData = loadMatrixFromResource("dropped_data.txt")?.transpose();
    });

    tearDownAll(() {
      testDataMatrix = null;
      dataToRotate = null;
      dataToFilter = null;
      dataToDownsample = null;
      dataToDetrend = null;
      dataToDrop = null;
      rotatedData = null;
      filteredData = null;
      downsampledData = null;
      detrendedData = null;
      droppedData = null;
    });

    test("rotate axis", () {
      final extracted = dataToRotate.extractRows();
      final rotatedDataMatrix = rotateAxis(extracted[0], extracted[1], extracted[2]);
      expect(rotatedDataMatrix.rows, equals(2));
      expect(rotatedDataMatrix.cols, equals(3093));
      rotatedDataMatrix.forEachIndexed((row, col, value) =>
        expect(value, within(distance: 0000000000000002, from: rotatedData.get(row, col))));
    });

//    test("filter data", () {
//      final filteredMatrix = filterData(dataToFilter);
//
//      expect(filteredMatrix.rows, equals(2));
//      expect(filteredMatrix.cols, equals(3093));
//      filteredMatrix.forEachIndexed((r,c,v) =>
//        expect(v, within(distance: 0.000000001, from: filteredData.get(r,c)));
//    });

    test("downsample data",() {
      final downsampledMatrix = downsample(dataToDownsample);

      expect(downsampledMatrix.rows, equals(2));
      expect(downsampledMatrix.cols, equals(1547));
      downsampledMatrix.forEachIndexed((r, c, v) =>
        expect(v, equals(downsampledData.get(r,c))));
    });

    test("detrend data", () {
      final detrendedMatrix = detrend(dataToDetrend);

      expect(detrendedMatrix.rows, equals(2));
      expect(detrendedMatrix.cols, equals(1547));
      detrendedMatrix.forEachIndexed((r, c, v) =>
        expect(v, within(distance: 0.00000000000005, from: detrendedData.get(r, c))));
    });

    test("drop first two seconds", () {
      final droppedMatrix = removeFirstTwoSecond(dataToDrop);

      expect(droppedMatrix.rows, equals(2));
      expect(droppedMatrix.cols, equals(dataToDrop.cols - 100));
      droppedMatrix.forEachIndexed((r, c, v) => expect(v, equals(droppedData.get(r,c))));
    });
  });
}

/// Load a [Matrix] from the [test_resources] directory
Matrix loadMatrixFromResource(String fileName) {
  File file = Directory.current.path.endsWith("test")
    ? File("test_resources/"+fileName)
    : File("test/test_resources/"+fileName);

  final List<double> result = [];
  final testDataLines = file.readAsLinesSync();
  if (testDataLines == null || testDataLines.isEmpty)
    return null;

  final colNum = testDataLines[0].split(" ").length;
  for(var line in testDataLines) {
    if (line.isEmpty)
      continue;
    final splitted = line.split(" ");
    for (var i = 0; i < colNum; i++) {
      result.add(double.parse(splitted[i]));
    }
  }
  return Matrix(testDataLines.length, colNum, result);
}