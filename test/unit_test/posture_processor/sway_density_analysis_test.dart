
import 'package:balance_app/posture_processor/src/math/matrix.dart';
import 'package:balance_app/posture_processor/src/sway_density_analysis.dart';
import 'package:flutter_test/flutter_test.dart';

import 'resource_loader.dart';

void main() {
  Matrix testData;

  setUpAll(() {
    testData = loadMatrixFromResource("dropped_data.txt").transpose();
  });

  test("compute sda", () async{
    expect(testData, isNotNull);
    final rows = testData.extractRows();
    Map param = await swayDensityAnalysis(rows[0], rows[1], 0.02);

    expect(param["numMax"], within(distance: 0.00001, from: 0.5));

    expect(param["meanDistance"], within(distance: 0.0005, from: 88.067));
    expect(param["stdDistance"], within(distance: 0.001, from: 86.968));

    expect(param["meanTime"], within(distance: 0.001, from: 88.067));
    expect(param["stdTime"], within(distance: 0.001, from: 86.968));

    expect(param["meanPeaks"], within(distance: 0.00001, from: 0.034280));
    expect(param["stdPeaks"], within(distance: 0.0001, from: 0.031166));
  });

  test("throws error when passed wrong args", (){
    // Throws an exception when the radius is 0?
    expect(() => swayDensityAnalysis([1.0, 2.0, 3.0], [4.0, 5.0, 6.0], 0.0), throwsAssertionError);

    // Throws an exception when the lists have different size?
    expect(() => swayDensityAnalysis([1.0, 2.0], [3.0, 4.0, 5.0], 0.2), throwsAssertionError);
  });
}