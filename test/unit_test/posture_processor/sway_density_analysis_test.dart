
import 'package:balance_app/posture_processor/math/matrix.dart';
import 'package:balance_app/posture_processor/sway_density_analysis.dart';
import 'package:flutter_test/flutter_test.dart';

import 'resource_loader.dart';

void main() {
  Matrix testData;

  setUpAll(() {
    testData = loadMatrixFromResource("dropped_data.txt").transpose();
  });

  test("compute sda", () {
    expect(testData, isNotNull);
    final rows = testData.extractRows();
    Map param = computeSwayDensityAnalysis(rows[0], rows[1], 0.5);

    expect(param["numMax"], equals(0.5));

    expect(param["meanDistance"], within(distance: 0.0005, from: 99.001));
    expect(param["stdDistance"], within(distance: 0.0001, from: 96.223));

    expect(param["meanTime"], equals(99.0));
    expect(param["stdTime"], within(distance: 0.0003, from: 96.223));

    expect(param["meanPeaks"], within(distance: 0.00001, from: 0.43618));
    expect(param["stdPeaks"], within(distance: 0.0001, from: 0.19870));
  });

  test("throws error when passed wrong args", (){
    // Throws an exception when the radius is 0?
    expect(() => computeSwayDensityAnalysis([1.0, 2.0, 3.0], [4.0, 5.0, 6.0], 0.0), throwsAssertionError);

    // Throws an exception when the lists have different size?
    expect(() => computeSwayDensityAnalysis([1.0, 2.0], [3.0, 4.0, 5.0], 0.2), throwsAssertionError);
  });
}