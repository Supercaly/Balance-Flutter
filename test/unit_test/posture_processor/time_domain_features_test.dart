
import 'package:balance_app/posture_processor/math/matrix.dart';
import 'package:balance_app/posture_processor/time_domain_features.dart';
import 'package:flutter_test/flutter_test.dart';

import 'resource_loader.dart';

void main() {

  Matrix testData;

  setUpAll(() {
    testData = loadMatrixFromResource("dropped_data.txt").transpose();
  });

  test("time domain features computation", () async{
    expect(testData, isNotNull);
    List<List<double>> rows = testData.extractRows();
    Map<String, double> timeFeat = await timeDomainFeatures(rows[0], rows[1]);

    expect(timeFeat["swayPath"], within(distance: 0.0001, from: 9.5771));
    expect(timeFeat["meanDisplacement"], within(distance: 0.01, from: 19.062));
    expect(timeFeat["stdDisplacement"], within(distance: 0.01, from: 7.1820));

    expect(timeFeat["minDist"], within(distance: 0.0001, from: 9.3025));
    expect(timeFeat["maxDist"], within(distance: 0.0001, from: 49.3992));
    expect(timeFeat["minDist"], lessThan(timeFeat["maxDist"]));
  });
}