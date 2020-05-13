
import 'package:balance_app/posture_processor/src/math/matrix.dart';
import 'package:balance_app/posture_processor/src/time_domain_features.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/resource_loader.dart';

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

  test("ml and ap with different sizes throws an error", () {
    expect(() => timeDomainFeatures([1.0], [1.0, 2.0]), throwsAssertionError);
  });
}