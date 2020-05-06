
import 'package:balance_app/posture_processor/src/math/matrix.dart';
import 'package:balance_app/posture_processor/src/time_domain_features.dart';
import 'package:flutter_test/flutter_test.dart';

import 'resource_loader.dart';

void main() {
  Matrix testData;

  setUpAll(() {
    testData = loadMatrixFromResource("dropped_data.txt").transpose();
  });

  tearDownAll(() {
    testData = null;
  });

  test("time domain features computation", () async{
    expect(testData, isNotNull);
    List<List<double>> rows = testData.extractRows();
    Map<String, double> timeFeat = await timeDomainFeatures(rows[0], rows[1]);

    expect(timeFeat["swayPath"], within(distance: 0.0001, from: 7.4081));
    expect(timeFeat["meanDisplacement"], within(distance: 0.01, from: 7.0124));
    expect(timeFeat["stdDisplacement"], within(distance: 0.01, from: 4.1026));

    expect(timeFeat["minDist"], within(distance: 0.0001, from: 0.50359));
    expect(timeFeat["maxDist"], within(distance: 0.0001, from: 25.96297));
    expect(timeFeat["minDist"], lessThan(timeFeat["maxDist"]));
  });
}